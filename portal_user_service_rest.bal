import ballerina/http;
import ballerina/mime;

service / on new http:Listener(9080) {

    # Retrieve organization image files.
    #
    # + orgName - parameter description  
    # + imageName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/images/[string imageName](http:Request request) returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/OrgLandingPage/images" + imageName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + imageName);
        return response;
    }

    # Retrieve organization video files.
    #
    # + orgName - parameter description  
    # + videoName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/video/[string videoName](http:Request request) returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/OrgLandingPage/assets/videos" + videoName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + videoName);
        return response;
    }

   # Retrieve organization template file.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgName]/template/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/OrgLandingPage/template" + fileName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }

    # Retrieve organization stylesheet.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgName]/stylesheet/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/OrgLandingPage/assets/stylesheet" + fileName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }

    # Retrieve api landing page image files.
    #
    # + orgName - parameter description  
    # + imageName - parameter description  
    # + request - parameter description
    # + return - return value description
    resource function get [string orgName]/[string apiName]/images/[string imageName](http:Request request) returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/APILandingPage" + apiName + "/assets/images" + imageName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + imageName);
        return response;
    }

   # Retrieve api landing page template files.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgName]/[string apiName]/template/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/APILandingPage" + apiName + "/template" + fileName);
        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }
    
    # Retrieve api landing page stylesheet.
    #
    # + orgId - parameter description  
    # + fileName - parameter description
    # + return - return value description
    resource function get [string orgName]/[string apiName]/stylesheet/[string fileName]() returns http:Response|error {

        mime:Entity file = new;
        file.setFileAsEntityBody("./files" + orgName + "/APILandingPage " + apiName + "/assets/stylesheet" + fileName);
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
