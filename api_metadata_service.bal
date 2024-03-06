import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;

final store:Client dbClient = check new ();

service /apiMetadata on new http:Listener(9090) {

    # Create an API.
    #
    # + metadata - api metadata
    # + return - api Id
    resource function post api(@http:Payload models:ApiMetadata metadata) returns http:Response|error {

        string apiId = check utils:createAPIMetadata(metadata);
        http:Response response = new;
        response.setPayload({apiId: apiId});
        return response;
    }

    resource function put api(string apiID, string orgName, models:ApiMetadata metadata) returns http:Response|error {

        string apiId = check utils:updateAPIMetadata(metadata, apiID, orgName);
        http:Response response = new;
        response.setPayload({apiId: apiId});
        return response;
    }

    resource function get api(string apiID, string orgName) returns models:ApiMetadata|error {

        store:ApiMetadataWithRelations apiMetaData = check userClient->/apimetadata/[apiID]/[orgName].get();
        store:ThrottlingPolicyOptionalized[] policies = apiMetaData.throttlingPolicies ?: [];
        store:AdditionalPropertiesWithRelations[] additionalProperties = apiMetaData.additionalProperties ?: [];
        store:ApiContentOptionalized[] apiContent = apiMetaData.apiContent ?: [];
        store:ApiImagesOptionalized[] apiImages = apiMetaData.apiImages ?: [];
        store:ReviewOptionalized[] apiReviews = apiMetaData.reviews ?: [];

        models:ThrottlingPolicy[] throttlingPolicies = [];
        models:APIReview[] reviews = [];

        foreach var policy in policies {
            models:ThrottlingPolicy policyData = {
                policyName: policy.policyName ?: "",
                description: policy.description ?: "",
                'type: policy.'type ?: ""
            };
            throttlingPolicies.push(policyData);
        }

        foreach var review in apiReviews {
            models:APIReview reviewData = {
                apiRating: review.rating ?: 0,
                apiComment: review.comment ?: "",
                apiReviewer: review.reviewedbyUserId ?: "",
                reviewId: review.reviewId ?: "",
                apiName: "",
                apiID: review.apifeedbackApiId ?: ""
            };
            reviews.push(reviewData);
        }

        map<string> properties = {};

        foreach var property in additionalProperties {
            properties[property.key ?: ""] = property.value ?: "";
        }

        map<string> apiContentRecord = {};

        foreach var property in apiContent {
            apiContentRecord[property.key ?: ""] = property.value ?: "";
        }

        map<string> apiImagesRecord = {};

        foreach var property in apiImages {
            apiImagesRecord[property.key ?: ""] = property.value ?: "";
        }

        models:ApiMetadata metaData = {
            serverUrl: {
                sandboxUrl: apiMetaData.sandboxUrl ?: "",
                productionUrl: apiMetaData.productionUrl ?: ""
            },
            throttlingPolicies: throttlingPolicies,
            apiInfo: {
                apiName: apiMetaData.apiName ?: "",
                apiCategory: apiMetaData.apiCategory ?: [],
                openApiDefinition: apiMetaData.openApiDefinition ?: "",
                additionalProperties: properties,
                reviews: reviews,
                orgName: apiMetaData.organizationName ?: "",
                apiArtifacts: {apiContent: apiContentRecord, apiImages: apiImagesRecord}
            }
        };

        return metaData;
    }
}

