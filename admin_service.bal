import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;
import ballerina/io;
import ballerina/persist;
import ballerina/uuid;
import ballerina/time;

# A service representing a network-accessible API
# bound to port `8080`.

final store:Client adminClient = check new ();

service /admin on new http:Listener(8080) {

    # Store the content for landing pages.
    #
    # + request - compressed file containing the folder content  
    # + orgName - organization name
    # + return - return value description
    resource function post orgTemplate(http:Request request, string orgName) returns models:ContentResponse|error {

        var bodyParts = check request.getBodyParts();
        string[] files = [];
        foreach var part in bodyParts {
            utils:handleContent(part);
            string fileContent = check part.getText();
            string fileName = part.getContentDisposition().fileName;
            string filePath = "./files/" + orgName + "/OrgLandingPage";
            files.push(fileName);
            if (fileName.endsWith(".html")) {
                check io:fileWriteString(filePath + "/template" + fileName, fileContent);
            } else if (fileName.endsWith(".md")) {
                check io:fileWriteString(filePath + "/content" + fileName, fileContent);
            } else if (fileName.endsWith(".css")) {
                check io:fileWriteString(filePath + "/assets/style" + fileName, fileContent);
            } else if (fileName.endsWith(".mp4") || fileName.endsWith(".webm") || fileName.endsWith(".ogv")) {
                check io:fileWriteString(filePath + "/assets/videos" + fileName, fileContent);
            } else if (fileName.endsWith(".png") || fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".gif") || fileName.endsWith(".svg") || fileName.endsWith(".ico") || fileName.endsWith(".webp")) {
                check io:fileWriteString(filePath + "/assets/images" + fileName, fileContent);
            } 
        }
        models:ContentResponse uploadedContent = {fileNames: files, timeUploaded: time:utcToString(time:utcNow(0))};
        return uploadedContent;
    }

    # Store the content for landing pages.
    #
    # + request - compressed file containing the folder content  
    # + orgName - organization name
    # + apiName - API name
    # + return - return value description
    resource function post apiTemplate(http:Request request, string orgName, string apiName) returns models:ContentResponse|error {

        var bodyParts = check request.getBodyParts();
        string[] files = [];
        foreach var part in bodyParts {
            utils:handleContent(part);
            string fileContent = check part.getText();
            string fileName = part.getContentDisposition().fileName;
            string filePath = "./files/" + orgName + "/OrgLandingPage" + apiName;
            files.push(fileName);
            if (fileName.endsWith(".html")) {
                check io:fileWriteString(filePath + "/template" + fileName, fileContent);
            } else if (fileName.endsWith(".md")) {
                check io:fileWriteString(filePath + "/content" + fileName, fileContent);
            } else if (fileName.endsWith(".css")) {
                check io:fileWriteString(filePath + "/assets/style" + fileName, fileContent);
            } else if (fileName.endsWith(".mp4") || fileName.endsWith(".webm") || fileName.endsWith(".ogv")) {
                check io:fileWriteString(filePath + "/assets/videos" + fileName, fileContent);
            } else if (fileName.endsWith(".png") || fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".gif") || fileName.endsWith(".svg") || fileName.endsWith(".ico") || fileName.endsWith(".webp")) {
                check io:fileWriteString(filePath + "/assets/images" + fileName, fileContent);
            } 
        }
        models:ContentResponse uploadedContent = {fileNames: files, timeUploaded: time:utcToString(time:utcNow(0))};
        return uploadedContent;
    }

    # Store the theme for the developer portal.
    #
    # + theme - theme object
    # + return - return value description
    resource function post theme(@http:Payload models:Theme theme) returns models:ThemeResponse {

        models:ThemeResponse createdTheme = {createdAt: "", themeId: "", orgId: ""};
        return createdTheme;
    }

    # Store the identity provider details for the developer portal.
    #
    # + identityProvider - IDP details
    # + return - return value description
    resource function post identityProvider(@http:Payload models:IdentityProvider identityProvider) returns models:IdentityProviderResponse|error {

        store:IdentityProviderInsert idp = {
            idpID: uuid:createType1AsString(),
            orgId: identityProvider.orgId,
            name: identityProvider.name,
            envrionments: identityProvider.envrionments,
            jwksEndpoint: identityProvider.jwksEndpoint,
            introspectionEndpoint: identityProvider.introspectionEndpoint,
            wellKnownEndpoint: identityProvider.wellKnownEndpoint,
            authorizeEndpoint: identityProvider.authorizeEndpoint,
            issuer: identityProvider.issuer
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

        stream<store:IdentityProvider, persist:Error?> identityProviders = adminClient->/identityproviders.get();
        store:IdentityProvider[] idpList = check from var idp in identityProviders
            where idp.orgId == orgId
            select idp;
        models:IdentityProvider[] idps = [];

        foreach var idp in idpList {
            idps.push(idp);
        }
        return idps;
    }

}

