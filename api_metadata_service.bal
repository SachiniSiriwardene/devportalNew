import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerina/time;

import ballerinacentral/zip;

service /apiMetadata on new http:Listener(9090) {

    # Store API Content
    #
    # + request - compressed file containing the folder content  
    # + orgName - organization name
    # + apiName - API name
    # + return - return value description
    resource function post apiContent(http:Request request, string orgName, string apiName) returns models:APIContentResponse|http:InternalServerError|error {

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./";
        check io:fileWriteBytes(path, binaryPayload);

        check zip:extract(path, targetPath);

        models:APIAssets assetMappings = {

            landingPageUrl: "",
            apiAssets: [],
            stylesheet: "",
            markdown: [],
            apiId: ""
        };

        file:MetaData[] directories = check file:readDir("./" + orgName + "/files/APILandingPage/" + apiName);
        models:APIAssets apiContent = check utils:getContentForAPITemplate(directories, orgName, assetMappings);

        store:OrganizationWithRelations organizationWithRelations = check utils:getOrgDetails(orgName);

        string templateName = organizationWithRelations.templateName ?: "";

        string apiId = check utils:getAPIId(orgName, apiName);

        apiContent.apiId = apiName;
        

        string apiLandingPage = "";
        if (!templateName.equalsIgnoreCaseAscii("custom")) {
            file:MetaData[] & readonly readDir = check file:readDir("./templates/" + templateName);
            foreach var file in readDir {
                if (file.absPath.endsWith("api-landing-page.html")) {
                    apiLandingPage = check file:relativePath(file:getCurrentDir(), file.absPath);
                }
            }
        } else {
            apiLandingPage = apiContent.landingPageUrl;
        }
        string aPIAssets = check utils:createAPIAssets(apiContent);
        models:APIContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: apiContent
        };
        return uploadedContent;
    }

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

    resource function get api(string apiID, string orgName) returns models:ApiMetadata|error {

        store:ApiMetadataWithRelations apiMetaData = check userClient->/apimetadata/[apiID].get();

        store:ThrottlingPolicyOptionalized[] policies = apiMetaData.throttlingPolicies ?: [];
        store:AdditionalPropertiesWithRelations[] additionalProperties = apiMetaData.additionalProperties ?: [];
        store:ApiContentOptionalized[] apiContent = apiMetaData.apiContent ?: [];
        store:ApiImagesOptionalized[] apiImages = apiMetaData.apiImages ?: [];
        store:ReviewOptionalized[] apiReviews = apiMetaData.reviews ?: [];
        store:APIAssetsOptionalized apiAssets = apiMetaData.assetMappings ?: {};

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
                apiLandingPageURL: apiAssets.landingPageUrl ?: "",
                apiAssets: {
                    apiAssets: apiAssets?.apiAssets ?: [],
                    landingPageUrl: apiAssets.landingPageUrl ?: "",
                    stylesheet: apiAssets.stylesheet ?: "",
                    markdown: apiAssets.markdown ?: [],
                    apiId: apiAssets.assetmappingsApiId ?: ""
                },
                orgName: apiMetaData.organizationName ?: "",
                apiArtifacts: {apiContent: apiContentRecord, apiImages: apiImagesRecord}
            }
        };
        
        return metaData;
    }
}

