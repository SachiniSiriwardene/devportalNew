import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;
import ballerina/persist;
import ballerina/regex;
import ballerina/time;
import ballerina/uuid;

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
            authenticatedPages: organization.authenticatedPages
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

            orgLandingPage: "",
            orgAssets: "",
            orgId: orgId,
            apiLandingPage: "",
            navigationBar: "",
            footerPage: "",
            apiListingPage: ""
        };

        string apiLandingPage = check io:fileReadString("./" + orgName + "/resources/template/api-landing-page.html");
        assetMappings.apiLandingPage = apiLandingPage;

        string orgLandingPage = check io:fileReadString("./" + orgName + "/resources/template/org-landing-page.html");
        assetMappings.orgLandingPage = orgLandingPage;

        string apiListingPage = check io:fileReadString("./" + orgName + "/resources/template/components-page.html");
        assetMappings.apiListingPage = apiListingPage;

        string navigationPage = check io:fileReadString("./" + orgName + "/resources/template/nav-bar.html");
        assetMappings.navigationBar = navigationPage;

        string footer = check io:fileReadString("./" + orgName + "/resources/template/footer.html");
        assetMappings.footerPage = footer;

        string orgAssets = check utils:createOrgAssets(assetMappings);

        log:printInfo("Org assets created: " + orgAssets);

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

            orgLandingPage: "",
            orgAssets: "",
            orgId: check orgId,
            apiLandingPage: "",
            navigationBar: "",
            footerPage: "",
            apiListingPage: ""
        };

        string apiLandingPage = check io:fileReadString("./" + orgName + "/resources/template/api-landing-page.html");
        assetMappings.apiLandingPage = apiLandingPage;

        string orgLandingPage = check io:fileReadString("./" + orgName + "/resources/template/org-landing-page.html");
        assetMappings.orgLandingPage = orgLandingPage;

        string apiListingPage = check io:fileReadString("./" + orgName + "/resources/template/components-page.html");
        assetMappings.apiListingPage = apiListingPage;

        string navigationPage = check io:fileReadString("./" + orgName + "/resources/template/nav-bar.html");
        assetMappings.navigationBar = navigationPage;

        string footer = check io:fileReadString("./" + orgName + "/resources/template/footer.html");
        assetMappings.footerPage = footer;

        string orgAssets = check utils:updateOrgAssets(assetMappings, orgName);

        check file:remove(orgName, file:RECURSIVE);

        log:printInfo("Org assets created: " + orgAssets);

        models:OrgContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: assetMappings
        };
        io:println("Organization content updated");
        return "Organization content updated successfully";
    }

    # Get the asset paths for the org or api.
    #
    # + orgName - parameter description  
    # + apiName - parameter description
    # + return - return value description
    resource function get assets(string orgName) returns models:OrganizationAssets|models:APIAssets|error {

        string orgId = check utils:getOrgId(orgName);
        log:printInfo("Org ID: " + orgId);
        models:OrganizationAssets organizationAssets = {
            orgLandingPage: "",
            orgAssets: "",
            orgId: "",
            apiLandingPage: "",
            navigationBar: "",
            footerPage: "",
            apiListingPage: ""
        };

        stream<store:OrganizationAssetsWithRelations, persist:Error?> orgAssets = adminClient->/organizationassets.get();
        store:OrganizationAssetsWithRelations[] assets = check from var asset in orgAssets
            where asset.organizationassetsOrgId == orgId
            select asset;

        log:printInfo("Org Assets" + assets.toString());

        foreach var asset in assets {
            organizationAssets = {
                orgLandingPage: asset.orgLandingPage ?: "",
                orgAssets: asset?.orgAssets ?: "",
                orgId: asset.organizationassetsOrgId ?: "",
                apiLandingPage: asset.apiLandingPage ?: "",
                navigationBar: "",
                footerPage: "",
                apiListingPage: ""
            };
        }
        return organizationAssets;

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
            where content.organizationassetsOrgId == orgId
            select content;

        mime:Entity file = new;
        if (filename.equalsIgnoreCaseAscii("org-landing-page.html")) {
            file.setBody(contents[0].orgLandingPage);
        } else if (filename.equalsIgnoreCaseAscii("api-landing-page.html")) {
            file.setBody(contents[0].apiLandingPage);
        } else if (filename.equalsIgnoreCaseAscii("components-page.html")) {
            file.setBody(contents[0].apiListingPage);
        } else if (filename.equalsIgnoreCaseAscii("nav-bar.html")) {
            file.setBody(contents[0].navigationBar);
        } else if (filename.equalsIgnoreCaseAscii("footer.html")) {
            file.setBody(contents[0].footerPage);
        }

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

        store:IdentityProviderInsert idp = {
            idpID: uuid:createType1AsString(),
            name: identityProvider.name,
            envrionments: identityProvider.envrionments,
            jwksEndpoint: identityProvider.jwksEndpoint,
            introspectionEndpoint: identityProvider.introspectionEndpoint,
            wellKnownEndpoint: identityProvider.wellKnownEndpoint,
            authorizeEndpoint: identityProvider.authorizeEndpoint,
            issuer: identityProvider.issuer,
            organizationOrgId: identityProvider.orgId
        };

        string[] listResult = check adminClient->/identityproviders.post([idp]);

        models:IdentityProviderResponse createdIDP = {createdAt: "", idpName: identityProvider.name, id: listResult[0]};
        return createdIDP;
    }

    # Retrieve identity providers.
    #
    # + orgId - parameter description
    # + return - list of identity providers for the organization.
    resource function get identityProvider(string orgId) returns models:IdentityProvider[]|error {

        stream<store:IdentityProviderWithRelations, persist:Error?> identityProviders = adminClient->/identityproviders.get();
        store:IdentityProviderWithRelations[] idpList = check from var idp in identityProviders
            select idp;
        models:IdentityProvider[] idps = [];

        foreach var idp in idpList {
            string idpOrgId = idp.organizationOrgId ?: "";
            if (orgId.equalsIgnoreCaseAscii(idpOrgId)) {

                models:IdentityProvider identityProvider = {
                    name: idp.name ?: "",
                    envrionments: idp.envrionments ?: "",
                    jwksEndpoint: idp.jwksEndpoint ?: "",
                    introspectionEndpoint: idp.introspectionEndpoint ?: "",
                    wellKnownEndpoint: idp.wellKnownEndpoint ?: "",
                    authorizeEndpoint: idp.authorizeEndpoint ?: "",
                    issuer: idp.issuer ?: "",
                    orgId: idp.organizationOrgId ?: ""
                };
                idps.push(identityProvider);
            }

        }
        return idps;
    }
}

