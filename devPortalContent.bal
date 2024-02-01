import ballerina/http;
import ballerina/io;

service / on new http:Listener(9090) {

    # Retrieve image files.
    #
    # + orgName - parameter description  
    # + imageName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/images/[string imageName](http:Request request) returns http:Response|error {

        byte[] content = check io:fileReadBytes("./files/" + imageName);
        http:Response response = new;
        check response.setContentType("application/octet-stream");
        response.setBinaryPayload(content);
        return response;
    }

    # Retrieve video files.
    #
    # + orgName - parameter description  
    # + videoName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/video/[string videoName](http:Request request) returns http:Response|error {

        byte[] content = check io:fileReadBytes("./files/" + videoName);
        http:Response response = new;
        check response.setContentType("application/octet-stream");
        response.setBinaryPayload(content);

        return response;
    }

    # Retrieve text files.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgId]/text/[string fileName]() returns http:Response|error {

        byte[] content = check io:fileReadBytes("./files/" + fileName);
        http:Response response = new;
        check response.setContentType("application/octet-stream");
        response.setBinaryPayload(content);

        return response;
    }

}
