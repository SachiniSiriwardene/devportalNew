import ballerina/http;
import ballerina/mime;

service / on new http:Listener(9080) {

    # Retrieve image files.
    #
    # + orgName - parameter description  
    # + imageName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/images/[string imageName](http:Request request) returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files/images" + imageName);
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
        file.setFileAsEntityBody("./files/assets/videos" + videoName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + videoName);
        return response;
    }

   # Retrieve template files.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgId]/template/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files/template" + fileName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }
    
    # Retrieve content files.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgId]/content/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files/content" + fileName);
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
