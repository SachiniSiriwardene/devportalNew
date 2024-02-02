import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;
import ballerina/io;
import ballerina/uuid;

# A service representing a network-accessible API
# bound to port `8080`.

final store:Client adminClient = check new ();

service /devPortalAdmin on new http:Listener(8080) {


    # Store the content for landing pages.
    #
    # + request - compressed file containing the folder content  
    # + content - file content type
    # + return - return value description
    resource function post admin/devPortalContent(http:Request request, string content) returns models:ContentResponse|error {

        var bodyParts = check request.getBodyParts();
        string[] files = [];
        foreach var part in bodyParts {
            utils:handleContent(part);
            string fileContent = check part.getText();
            string fileName = part.getContentDisposition().fileName;
            files.push(fileName);
            check io:fileWriteString("./files/" + fileName, fileContent);
        }
        io:println(content);
        models:ContentResponse uploadedContent = {createdAt: "", contentId: "1", fileNames: files};
        return uploadedContent;
    }

    # Store the theme for the developer portal.
    #
    # + theme - theme object
    # + return - return value description
    resource function post admin/theme(@http:Payload models:Theme theme) returns models:ThemeResponse {

        models:ThemeResponse createdTheme = {createdAt: "", themeId: "", orgId: ""};
        return createdTheme;
    }

    # Store the identity provider details for the developer portal.
    #
    # + identityProvider - IDP details
    # + return - return value description
    resource function post admin/identityProvider(@http:Payload models:IdentityProvider identityProvider) returns models:IdentityProviderResponse|error {

        store:IdentityProviderInsert idp = {
            idpID: uuid:createType1AsString(),
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

}

