import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;
import ballerina/io;
import ballerina/uuid;

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

    resource function post api(@http:Payload models:ApiMetadata metadata) returns http:Response|error {
        final store:Client sClient = check new ();

        models:ThrottlingPolicy[] throttlingPolicies = metadata.throttlingPolicies ?: [];
        store:ThrottlingPolicyInsert[] throttlingPolicyRecords = [];
        string apiID = uuid:createType1AsString();

        foreach var policy in throttlingPolicies {
            throttlingPolicyRecords.push({
                apimetadataApiId: apiID,
                policyId: uuid:createType1AsString(),
                'type: policy.'type,
                policyName: policy.policyName,
                description: policy.description
            });
        }

        map<string> additionalProperties = metadata.apiInfo.additionalProperties;
        store:AdditionalPropertiesInsert[] additionalPropertiesRecords = [];

        foreach var propertyKey in additionalProperties.keys() {
            additionalPropertiesRecords.push({
                apimetadataApiId: apiID,
                propertyId: uuid:createType1AsString(),
                'key: propertyKey,
                value: additionalProperties.get(propertyKey)
            });
        }

        store:ApiMetadataInsert metadataRecord = {
            apiId: apiID,
            orgId: uuid:createType1AsString(),
            apiName: metadata.apiInfo.apiName,
            apiCategory: metadata.apiInfo.apiCategory,
            apiImage: metadata.apiInfo.apiImage,
            openApiDefinition: metadata.apiInfo.openApiDefinition,
            productionUrl: metadata.serverUrl.productionUrl,
            sandboxUrl: metadata.serverUrl.sandboxUrl
        };
        string[] apiIDs = check sClient->/apimetadata.post([metadataRecord]);

        if (metadataRecord.length() > 0) {
            http:Response response = new;
            response.setPayload({apiId: apiIDs});
            return response;
        }
        return error("Error occurred while adding the API metadata");
    }
}

