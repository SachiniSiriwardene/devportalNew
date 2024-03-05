import devportal.models;
import devportal.utils;

import ballerina/http;

service /apiMetadata on new http:Listener(9090) {

    # Create an API.
    #
    # + metadata - api metadata
    # + return - api Id
    resource function post api(@http:Payload models:ApiMetadata metadata) returns http:Response|error {

        string apiId = check utils:createAPI(metadata);
        http:Response response = new;
        response.setPayload({apiId: apiId});
        return response;
    }
}

