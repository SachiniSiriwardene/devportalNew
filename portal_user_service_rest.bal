import ballerina/file;
import ballerina/http;
import ballerina/log;
import ballerina/mime;
import ballerina/file;

service / on new http:Listener(3001) {

    # Retrieve organization template file.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgName]/files/[string folder]/[string page]/[string fileName](http:Request request) returns http:Response {

        mime:Entity file = new;
        log:printInfo("./" + request.rawPath);

        do {
            boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);
            if (dirExists) {
                file.setFileAsEntityBody("." + request.rawPath);
            }
        } on fail var e {
            log:printError("Error occurred while checking file existence: " + e.message());
        }

        log:printInfo("Bingo");
        http:Response response = new;
        response.setEntity(file);
        do {
            check response.setContentType("application/octet-stream");
        } on fail var e {
            log:printError("Error occurred while setting content type: " + e.message());
        }
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }
}
