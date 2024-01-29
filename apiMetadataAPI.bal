import devportal.models;
import devportal.store;

import ballerina/http;
import ballerina/random;

service /apiMetadata on new http:Listener(9090) {

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
    // resource function get api(string apiId) returns models:ApiMetadataRecord|error {
    //     table<models:ApiMetadata> metadataRecords = from var metadataRecord in entry:apiMetadataTable
    //         where metadataRecord.apiId == apiId
    //         select metadataRecord;
    //     if (metadataRecords.length() > 0) {
    //         return metadataRecords.toArray().first()[0];
    //     }
    //     return error("Error occurred while retrieving the API metadata");
    // }
}
