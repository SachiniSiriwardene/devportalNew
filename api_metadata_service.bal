import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;
import ballerina/persist;
import ballerina/regex;

import ballerinacentral/zip;

service /apiMetadata on new http:Listener(9090) {

    # Create an API.
    #
    # + metadata - api metadata
    # + return - api Id
    resource function post api(@http:Payload models:ApiMetadata metadata) returns http:Response|error {

        string apiId = check utils:createAPIMetadata(metadata);
        utils:addApiImages(metadata.apiInfo.apiArtifacts.apiImages, apiId, metadata.apiInfo.orgName);
        http:Response response = new;
        response.setPayload({apiId: apiId});
        return response;
    }

    resource function put api(string apiID, string orgName, models:ApiMetadata metadata) returns http:Response|error {

        string apiId = check utils:updateAPIMetadata(metadata, apiID, orgName);
        utils:addApiImages(metadata.apiInfo.apiArtifacts.apiImages, apiId, metadata.apiInfo.orgName);
        http:Response response = new;
        response.setPayload({apiId: apiId});
        return response;
    }

    resource function get api(string apiID, string orgName) returns models:ApiMetadataResponse|error {

        store:ApiMetadataWithRelations apiMetaData = check adminClient->/apimetadata/[apiID]/[orgName].get();
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

        string[] apiContentRecord = [];

        foreach var property in apiContent {
            apiContentRecord.push(property.apiContent ?: "");
        }

        map<string> apiImagesRecord = {};

        foreach var property in apiImages {
            apiImagesRecord[property.key ?: ""] = property.value ?: "";
        }
        string apiDefinition = check apiMetaData.openApiDefinition ?: "";
        json openApiDefinition = check apiDefinition.fromJsonString();

        string version = check openApiDefinition.info.version;
        models:ApiMetadataResponse metaData = {
            serverUrl: {
                sandboxUrl: apiMetaData.sandboxUrl ?: "",
                productionUrl: apiMetaData.productionUrl ?: ""
            },
            throttlingPolicies: throttlingPolicies,
            apiInfo: {
                apiName: apiMetaData.apiName ?: "",
                apiCategory: apiMetaData.apiCategory ?: "",
                openApiDefinition: openApiDefinition,
                additionalProperties: properties,
                reviews: reviews,
                orgName: apiMetaData.organizationName ?: "",
                apiArtifacts: {apiContent: apiContentRecord, apiImages: apiImagesRecord},
                apiVersion: version,
                authorizedRoles: regex:split(apiMetaData?.authorizedRoles ?: "", " ")
            }
        };
        log:printInfo(apiMetaData?.authorizedRoles ?: "");

        return metaData;
    }

    resource function get apiList(string orgName) returns models:ApiMetadataResponse[]|error {

        //retrieve the organization id
        string orgId = check utils:getOrgId(orgName);
        stream<store:ApiMetadataWithRelations, persist:Error?> apiMetaDataList = adminClient->/apimetadata.get();

        store:ApiMetadataWithRelations[] apiList = check from var api in apiMetaDataList
            where api.orgId == orgId
            select api;

        models:ApiMetadataResponse[] apis = [];
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

            string[] apiContentRecord = [];

            foreach var property in apiContent {
                apiContentRecord.push(property.apiContent ?: "");
            }

            map<string> apiImagesRecord = {};

            foreach var property in apiImages {
                apiImagesRecord[property.key ?: ""] = property.value ?: "";
            }

            string apiDefinition = check apiMetaData.openApiDefinition ?: "";
            json openApiDefinition = check apiDefinition.fromJsonString();
            string version = check openApiDefinition.info.version;

            models:ApiMetadataResponse metaData = {
                serverUrl: {
                    sandboxUrl: apiMetaData.sandboxUrl ?: "",
                    productionUrl: apiMetaData.productionUrl ?: ""
                },
                throttlingPolicies: throttlingPolicies,
                apiInfo: {
                    apiName: apiMetaData.apiName ?: "",
                    apiCategory: apiMetaData.apiCategory ?: "",
                    openApiDefinition: apiMetaData.openApiDefinition ?: "",
                    additionalProperties: properties,
                    reviews: reviews,
                    orgName: apiMetaData.organizationName ?: "",
                    apiArtifacts: {apiContent: apiContentRecord, apiImages: apiImagesRecord},
                    apiVersion: version,
                    authorizedRoles: regex:split(apiMetaData?.authorizedRoles ?: "", " ")
                }
            };
            apis.push(metaData);
        }
        return apis;
    }

    resource function post apiContent(http:Request request, string orgName, string apiName) returns string|error {

        string apiId = check utils:getAPIId(orgName, apiName);

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./" + orgName + "/";
        check io:fileWriteBytes(path, binaryPayload);
        error? result = check zip:extract(path, targetPath);

        file:MetaData[] directories = check file:readDir("./" + orgName + "/" + apiName + "/content");

        models:APIAssets apiAssets = {apiContent: "", apiImages: [], apiId: apiId};
        apiAssets = check utils:readAPIContent(directories, orgName, apiName, apiAssets);

        check file:createDir("./" + orgName + "/resources/images", file:RECURSIVE);
        check file:copy("./" + orgName + "/" + apiName + "/images", "./" + orgName + "/resources/images");
        file:MetaData[] imageDir = check file:readDir("./" + orgName + "/resources/images");
        check utils:pushContentS3(imageDir, "text/plain");
        check file:remove(orgName, file:RECURSIVE);
        utils:addApiContent(apiAssets, apiId, orgName);

        io:println("API content added successfully");
        return "API asset updated";

    }

    resource function get [string filename](string orgName, string apiID, http:Request request) returns error|http:Response {
        stream<store:ApiContent, persist:Error?> apiContent = adminClient->/apicontents.get();
        store:ApiContent[] contents = check from var content in apiContent
            where content.apimetadataApiId == apiID
            select content;

        mime:Entity file = new;
        if (contents.length() > 0) {
            file.setBody(contents[0].apiContent);
        }

        http:Response response = new;
        response.setEntity(file);
        check response.setContentType("application/octet-stream");
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");

        return response;
    }
}

