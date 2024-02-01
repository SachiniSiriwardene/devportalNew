import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;
import ballerina/io;
import ballerina/random;


service /apiMetadata on new http:Listener(9090) {

    resource function post apiContent(http:Request request)
            returns http:Response|http:InternalServerError|error {
        var bodyParts = check request.getBodyParts();

        foreach var part in bodyParts {
            utils:handleContent(part);
            string fileContent = check part.getText();
            string fileName = part.getContentDisposition().fileName;
            check io:fileWriteString("./files/" + fileName, fileContent);
        }
        http:Response response = new;
        response.setPayload("File uploaded successfully");
        return response;

    }

    resource function post api(@http:Payload models:ApiMetadata metadata) returns json|error {

        models:ThrottlingPolicy[] throttlingPolicies = metadata.throttlingPolicies ?: [];
        store:ThrottlingPolicy[] throttlingPolicyRecords = [];

        foreach var policy in throttlingPolicies {
            throttlingPolicyRecords.push({
                apimetadataApiId: "123",
                policyId: (check random:createIntInRange(1, 999)).toString(),
                'type: policy.'type,
                policyName: policy.policyName,
                description: policy.description
            });
        }

        map<string> additionalProperties = metadata.apiInfo.additionalProperties;
        store:AdditionalProperties[] additionalPropertiesRecords = [];

        foreach var propertyKey in additionalProperties.keys() {
            additionalPropertiesRecords.push({
                apimetadataApiId: "123",
                propertyId: (check random:createIntInRange(1, 999)).toString(),
                'key: propertyKey,
                value: additionalProperties.get(propertyKey)
            });
        }

        store:ApiMetadata metadataRecord = {
            apiId: "123",
            orgId: "234",
            apiName: metadata.apiInfo.apiName,
            apiCategory: metadata.apiInfo.apiCategory,
            apiImage: metadata.apiInfo.apiImage,
            openApiDefinition: metadata.apiInfo.openApiDefinition,
            productionUrl: metadata.serverUrl.productionUrl,
            sandboxUrl: metadata.serverUrl.sandboxUrl
        };

        if (metadataRecord.length() > 0) {
            return metadataRecord.toJson();
        }
        return error("Error occurred while adding the API metadata");
    }
}

