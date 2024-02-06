import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;
import ballerina/io;
import ballerina/uuid;
import ballerina/time;

service /apiMetadata on new http:Listener(9090) {

    
    # Store API Content
    #
    # + request - compressed file containing the folder content  
    # + orgName - organization name
    # + apiName - API name
    # + return - return value description
    resource function post apiContent(http:Request request, string orgName, string apiName) returns models:ContentResponse|http:InternalServerError|error {
        var bodyParts = check request.getBodyParts();
        string[] files = [];

        foreach var part in bodyParts {
            utils:handleContent(part);
            string fileContent = check part.getText();
            string fileName = part.getContentDisposition().fileName;
            string filePath = "./files/" + orgName + "/APILandingPage/" + apiName;
            files.push(fileName);
            if (fileName.endsWith(".md")) {
                check io:fileWriteString(filePath + "/content/" + fileName, fileContent);
            } else if (fileName.endsWith(".png") || fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".gif") || fileName.endsWith(".svg") || fileName.endsWith(".ico") || fileName.endsWith(".webp")) {
                check io:fileWriteString(filePath + "/assets/images/" + fileName, fileContent);
            } 
        }
        models:ContentResponse uploadedContent = {fileNames: files, timeUploaded: time:utcToString(time:utcNow(0))};
        return uploadedContent;
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
            openApiDefinition: metadata.apiInfo.openApiDefinition,
            productionUrl: metadata.serverUrl.productionUrl,
            sandboxUrl: metadata.serverUrl.sandboxUrl
        };
        string[] apiIDs = check sClient->/apimetadata.post([metadataRecord]);

        if (metadataRecord.length() > 0) {
            http:Response response = new;
            response.setPayload({apiId: apiIDs[0]});
            return response;
        }
        return error("Error occurred while adding the API metadata");
    }
}

