import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerina/mime;
import ballerina/persist;
import ballerina/regex;
import ballerina/time;

import ballerinacentral/zip;

// # A service representing a network-accessible API
// # bound to port `8080`.

final store:Client adminClient = check new ();

service /admin on new http:Listener(8080) {

    resource function post organisation(models:Organization organization) returns models:OrgCreationResponse|error {

        string orgId = check utils:createOrg(organization);
        models:OrgCreationResponse org = {
            orgName: organization.orgName,
            orgId: orgId,
            isPublic: organization.isPublic,
            authenticatedPages: organization.authenticatedPages ?: []
        };
        return org;
    }

        resource function put organisation(models:Organization organization) returns models:OrgCreationResponse|error {

        string orgId = check utils:updateOrg(organization);
        models:OrgCreationResponse org = {
            orgName: organization.orgName,
            orgId: orgId,
            isPublic: organization.isPublic,
            authenticatedPages: organization.authenticatedPages ?: []
        };
        return org;
    }

    resource function get organisation(string orgName) returns models:OrgCreationResponse|error {

        store:OrganizationWithRelations organization = check utils:getOrgDetails(orgName);

        models:OrgCreationResponse org = {
            orgName: organization.organizationName ?: "",
            orgId: organization.orgId ?: "",
            isPublic: organization.isPublic ?: false,
            authenticatedPages: regex:split(organization.authenticatedPages ?: "", " ")
        };
        return org;
    }

    # Description.
    #
    # + orgName - parameter description
    # + return - return value description
    resource function post orgContent(http:Request request, string orgName) returns string|error {

        string orgId = check utils:getOrgId(orgName);

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./" + orgName;
        check io:fileWriteBytes(path, binaryPayload);

        error? result = check zip:extract(path, targetPath);

        models:OrganizationAssets assetMappings = {
            pageType: "",
            pageContent: "",
            orgId: orgId
        };

        file:MetaData[] readDirResults = check file:readDir("./" + orgName + "/resources/template");

        foreach var file in readDirResults {
            assetMappings.pageType = file.absPath.substring(<int>(file.absPath.lastIndexOf("/") + 1), file.absPath.length());
            assetMappings.pageContent = check io:fileReadString(file.absPath);
            string orgAssets = check utils:createOrgAssets(assetMappings);
        }

        models:OrgContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: assetMappings
        };

        file:MetaData[] imageDir = check file:readDir("./" + orgName + "/resources/images");
        check utils:pushContentS3(imageDir, "text/plain");

        file:MetaData[] stylesheetDir = check file:readDir("./" + orgName + "/resources/stylesheet");
        check utils:pushContentS3(stylesheetDir, "text/css");

        check file:remove(orgName, file:RECURSIVE);

        io:println("Organization content uploaded");
        return "Organization content uploaded successfully";

    }

    # Store the organization landing page content.
    #
    # + request - parameter description  
    # + orgName - parameter description
    # + return - return value description
    resource function put orgContent(http:Request request, string orgName) returns string|error {

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./" + orgName;
        check io:fileWriteBytes(path, binaryPayload);

        boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);

        if (dirExists) {
            file:Error? remove = check file:remove(orgName);
        }

        error? result = check zip:extract(path, targetPath);

        //check whether org exists
        string|error orgId = utils:getOrgId(orgName);

        models:OrganizationAssets assetMappings = {
            pageType: "",
            pageContent: "",
            orgId: check orgId
        };

        file:MetaData[] readDirResults = check file:readDir("./" + orgName + "/resources/template");

        foreach var file in readDirResults {
            assetMappings.pageType = file.absPath.substring(<int>(file.absPath.lastIndexOf("/") + 1), file.absPath.length());
            assetMappings.pageContent = check io:fileReadString(file.absPath);
            string orgAssets = check utils:updateOrgAssets(assetMappings, orgName);
        }



        check file:remove(orgName, file:RECURSIVE);


        models:OrgContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: assetMappings
        };
        io:println("Organization content updated");
        return "Organization content updated successfully";
    }

    # Retrieve landing pages.
    #
    # + filename - parameter description  
    # + orgName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string filename](string orgName, http:Request request) returns error|http:Response {

        string orgId = check utils:getOrgId(orgName);
        stream<store:OrganizationAssets, persist:Error?> orgContent = adminClient->/organizationassets.get();

        store:OrganizationAssets[] contents = check from var content in orgContent
            where content.organizationOrgId == orgId && content.pageType == filename
            select content;

        mime:Entity file = new;
        file.setBody(contents[0].pageContent);
        

        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");

        return response;
    }

    # Store the identity provider details for the developer portal.
    #
    # + identityProvider - IDP details
    # + return - return value description
    resource function post identityProvider(@http:Payload models:IdentityProvider identityProvider) returns models:IdentityProviderResponse|error {

        string identityProviderResult = check utils:addIdentityProvider(identityProvider);

        models:IdentityProviderResponse createdIDP = {
            id: identityProvider.id,
            clientId: identityProvider.clientId,
            name: identityProvider.name,
            clientSecret: identityProvider.clientSecret,
            'type: identityProvider.'type,
            issuer: identityProvider.issuer
        };
        return createdIDP;
    }

    # Retrieve identity providers.
    #
    # + orgName - parameter description
    # + return - list of identity providers for the organization.
    resource function get identityProvider(string orgName) returns models:IdentityProviderResponse[]|error {

        store:IdentityProviderWithRelations[] idpList = check utils:getIdentityProviders(orgName);
        models:IdentityProviderResponse[] idps = [];
        foreach var idp in idpList {
            models:IdentityProviderResponse identityProvider = {
                name: idp.name ?: "",
                issuer: idp.issuer ?: "",
                clientId: idp.clientId ?: "",
                clientSecret: idp.clientSecret ?: "",
                id: idp.id ?: "",
                'type: idp.'type ?: ""
            };
            idps.push(identityProvider);

        }
        return idps;
    }
}

