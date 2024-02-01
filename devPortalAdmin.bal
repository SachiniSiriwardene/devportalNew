import devportal.models;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /devPortalAdmin on new http:Listener(8080) {

    # Store the content for landing pages.
    #
    # + request - compressed file containing the folder content 
    # + return - return value description
    resource function post admin/devPortalContent(http:Request request) returns models:ContentResponse {

        // byte[]|http:ClientError binaryPayload = request.getBinaryPayload();
        // stream<byte[], io:Error?>|http:ClientError byteSteam = request.getByteStream();

        // if binaryPayload is byte[] {
        //     javaio:InputStream|error zipFile = javaio:newByteArrayInputStream1(binaryPayload);
        //     if (zipFile is javaio:InputStream) {
        //         zip:ZipInputStream zip = zip:newZipInputStream1(zipFile);
        //         zip:ZipEntry entry;
        //         //       while(zip.getNextEntry()!=null)
        //         // {

        //         // }
        //     }
        // }
        models:ContentResponse uploadedContent = {createdAt: "", contentId: "", fileNames: []};
        return uploadedContent;
    }

     # Store the resources related to dev portal ex:images, videos.
     #
     # + request - parameter description
     # + return - return value description
     resource function post admin/resources(http:Request request) returns models:ContentResponse {

        // byte[]|http:ClientError binaryPayload = request.getBinaryPayload();
        // stream<byte[], io:Error?>|http:ClientError byteSteam = request.getByteStream();

        // if binaryPayload is byte[] {
        //     javaio:InputStream|error zipFile = javaio:newByteArrayInputStream1(binaryPayload);
        //     if (zipFile is javaio:InputStream) {
        //         zip:ZipInputStream zip = zip:newZipInputStream1(zipFile);
        //         zip:ZipEntry entry;
        //         //       while(zip.getNextEntry()!=null)
        //         // {

        //         // }
        //     }
        // }
        models:ContentResponse uploadedContent = {createdAt: "", contentId: "", fileNames: []};
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
    resource function post admin/identityProvider(@http:Payload models:IdentityProvider identityProvider) returns models:IdentityProviderResponse {

        models:IdentityProviderResponse createdIDP = {createdAt: "", idpName: "", id: ""};
        return createdIDP;
    }

}

