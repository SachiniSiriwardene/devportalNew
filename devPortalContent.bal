import ballerina/http;
import ballerina/mime;

service / on new http:Listener(9090) {

    # Retrieve image files.
    #
    # + orgName - parameter description  
    # + imageName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/images/[string imageName](http:Request request) returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files/" + imageName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + imageName);
        return response;
    }

    # Retrieve video files.
    #
    # + orgName - parameter description  
    # + videoName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/video/[string videoName](http:Request request) returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files/" + videoName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + videoName);
        return response;
    }

    # Retrieve text files.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgId]/text/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files/" + fileName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }

}
