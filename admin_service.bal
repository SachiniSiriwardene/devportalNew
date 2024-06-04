import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;
import ballerina/regex;

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

        file:MetaData[] templateDir = check file:readDir("./" + orgName + "/resources/template");
        file:MetaData[] imageDir = check file:readDir("./" + orgName + "/resources/images");
        file:MetaData[] stylesheetDir = check file:readDir("./" + orgName + "/resources/stylesheet");

        if (models:awsAccessKeyId.equalsIgnoreCaseAscii("")) {
            check utils:pushContentS3(imageDir, "text/plain");
            check utils:pushContentS3(stylesheetDir, "text/css");
            log:printInfo("Added content to S3 successfully");
        } else {
            file:MetaData[] content = [];
            content.push(...templateDir);
            content.push(...stylesheetDir);
            models:OrganizationAssets[] assetMappings = [];
            foreach var file in content {
                string pageType = file.absPath.substring(<int>(file.absPath.lastIndexOf("/") + 1), file.absPath.length());
                if (!pageType.equalsIgnoreCaseAscii(".DS_Store")) {
                    string pageContent = check io:fileReadString(file.absPath);
                    models:OrganizationAssets assetMapping = {
                        pageType: pageType,
                        pageContent: pageContent,
                        orgId: orgId
                    };
                    assetMappings.push(assetMapping);
                }
            }
            string _ = check utils:createOrgAssets(assetMappings);
            models:OrgImages[] orgImages = [];
            foreach var file in imageDir {
                string imageName = check file:relativePath(file:getCurrentDir(), file.absPath);
                orgImages.push({
                    image: check io:fileReadBytes(check file:relativePath(file:getCurrentDir(), file.absPath)),
                    imageName: imageName.substring(<int>(imageName.lastIndexOf("/") + 1), imageName.length())
                }
                );
            }
            string _ = check utils:storeOrgImages(orgImages, orgId);
        }
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

        string orgId = check utils:getOrgId(orgName);

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./" + orgName;
        check io:fileWriteBytes(path, binaryPayload);

        error? result = check zip:extract(path, targetPath);

        file:MetaData[] templateDir = check file:readDir("./" + orgName + "/resources/template");
        file:MetaData[] imageDir = check file:readDir("./" + orgName + "/resources/images");
        file:MetaData[] stylesheetDir = check file:readDir("./" + orgName + "/resources/stylesheet");

        if (models:awsAccessKeyId.equalsIgnoreCaseAscii("")) {
            check utils:pushContentS3(imageDir, "text/plain");
            check utils:pushContentS3(stylesheetDir, "text/css");
            log:printInfo("Added content to S3 successfully");
        } else {
            file:MetaData[] content = [];
            content.push(...templateDir);
            content.push(...stylesheetDir);
            models:OrganizationAssets[] assetMappings = [];
            foreach var file in content {
                string pageType = file.absPath.substring(<int>(file.absPath.lastIndexOf("/") + 1), file.absPath.length());
                if (!pageType.equalsIgnoreCaseAscii(".DS_Store")) {
                    string pageContent = check io:fileReadString(file.absPath);
                    models:OrganizationAssets assetMapping = {
                        pageType: pageType,
                        pageContent: pageContent,
                        orgId: orgId
                    };
                    assetMappings.push(assetMapping);
                }
            }
            string _ = check utils:updateOrgAssets(assetMappings);
            models:OrgImages[] orgImages = [];
            foreach var file in imageDir {
                string imageName = check file:relativePath(file:getCurrentDir(), file.absPath);
                orgImages.push({
                    image: check io:fileReadBytes(check file:relativePath(file:getCurrentDir(), file.absPath)),
                    imageName: imageName.substring(<int>(imageName.lastIndexOf("/") + 1), imageName.length())
                }
                );
            }
            string _ = check utils:updateOrgImages(orgImages, orgId);
        }
        check file:remove(orgName, file:RECURSIVE);
        io:println("Organization content uploaded");
        return "Organization content uploaded successfully";
    }

    # Retrieve landing pages.
    #
    # + filename - parameter description  
    # + orgName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string filename](string orgName, http:Request request) returns error|http:Response {

        string orgId = check utils:getOrgId(orgName);
        mime:Entity file = new;
        http:Response response = new;
        if (filename.endsWith("html") || filename.endsWith("css")) {
            store:OrganizationAssets[] contents = check utils:retrieveOrgFiles(filename, orgId) ?: [];
            if (contents.length() > 0) {
                file.setBody(contents[0].pageContent);
                response.setEntity(file);
                check response.setContentType("application/octet-stream");
                response.setHeader("Content-Type", "text/css");
                response.setHeader("Content-Description", "File Transfer");
                response.setHeader("Transfer-Encoding", "chunked");
            } else {
                response.statusCode = 404;
                response.setPayload("Requested file not found");
            }
        } else {
            store:OrgImages[] images = check utils:retrieveOrgImages(filename, orgId) ?: [];
            if (images.length() > 0) {
                file.setBody(images[0].image);
                response.setEntity(file);
                check response.setContentType("application/octet-stream");
                response.setHeader("Content-Type", "application/octet-stream");
                response.setHeader("Content-Description", "File Transfer");
                response.setHeader("Transfer-Encoding", "chunked");
            } else {
                response.statusCode = 404;
                response.setPayload("Requested file not found");
            }
        }
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

