import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/http;
import ballerina/persist;
import ballerina/io;
import ballerina/file;
import ballerinacentral/zip;

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

    resource function get apiList(string orgName) returns models:ApiMetadata[]|error {

        //retrieve the organization id
        string orgId = check utils:getOrgId(orgName);
        stream<store:ApiMetadataWithRelations, persist:Error?> apiMetaDataList = userClient->/apimetadata.get();

        store:ApiMetadataWithRelations[] apiList = check from var api in apiMetaDataList
            where api.orgId == orgId
            select api;

        models:ApiMetadata[] apis = [];
        foreach var apiMetaData in apiList {

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
            apis.push(metaData);
        }
        return apis;
    }

     resource function post apiContent(http:Request request, string orgName, string apiName) returns string|error {

        string orgId = check utils:getOrgId(orgName);

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./" + orgName + "/resources/content/";
        check io:fileWriteBytes(path, binaryPayload);

        boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);

        if (dirExists) {
            file:Error? remove = check file:remove(orgName);
        }

        error? result = check zip:extract(path, targetPath);

        check file:copy(targetPath + apiName + "/images/", "./" + orgName + "/resources/images",file:COPY_ATTRIBUTES);

        //check file:remove(orgName + "/resources/content/" + apiName + "/images/");



       
      
       
        return "API asset updated";

    }

}

