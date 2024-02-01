import devportal.models;

import ballerina/http;

service /devPortalContent on new http:Listener(9090) {

    # Retrieve image files.
    #
    # + orgId - parameter description  
    # + imageName - parameter description
    # + return - return value description
    resource function get [string orgId]/images/[string imageName]() returns http:Response {

       

      

        return api;
    }

     # Retrieve video files.
     #
     # + orgId - parameter description  
     # + videoName - parameter description
     # + return - return value description
     resource function get [string orgId]/video/[string videoName]() returns http:Response {

        //stream<store:ApiMetadata, persist:Error?> employees = sClient->/apiMetaData;

        // models:ApiMetadata? apiContent = sClient->/store:ApiMetadata;

        models:ApiMetadata api = {
            serverUrl: {sandboxUrl: "", productionUrl: ""},
            throttlingPolicies: (),
            apiInfo: {apiName: "", apiCategory: [], apiImage: , openApiDefinition: "", additionalProperties: {}}
        };

        return api;
    }

      # Retrieve text files.
      #
      # + orgId - parameter description  
      # + fileName - parameter description
      # + return - return value description
      resource function get [string orgId]/text/[string fileName]() returns http:Response {

       

      

        return api;
    }



}
