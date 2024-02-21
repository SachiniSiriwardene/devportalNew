import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/persist;
import ballerina/time;
import ballerina/uuid;

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
            stylesheets: [],
            markdown: []
        };

        file:MetaData[] directories = check file:readDir(targetPath + "/" + orgName);
        models:APIAssets apiContent = check utils:getContentForAPITemplate(directories, orgName, assetMappings);

        stream<store:OrganizationWithRelations, persist:Error?> organizations = adminClient->/organizations.get();

        //retrieve the organization id
        store:OrganizationWithRelations[] organization = check from var org in organizations
            where org.organizationName == orgName
            select org;
        if (organization.length() == 0) {
            log:printInfo("No organization found");
        } else if (organization.length() == 1) {
        }
        store:OrganizationWithRelations org = organization.pop();
        string templateName = "";
        store:ThemeOptionalized[] theme = org.theme ?: [];

        templateName = theme.pop().templateId ?: "";
        string orgId = "";
        string apiId = "";
        orgId = org.orgId ?: "";

        stream<store:ApiMetadata, persist:Error?> apis = adminClient->/apimetadata.get();

        //retrieve the api id
        store:ApiMetadata[] matchedAPI = check from var api in apis
            where api.apiName == apiName && api.orgId == orgId
            select api;

        if (matchedAPI.length() == 0) {
            log:printInfo("No api found");
        } else if (matchedAPI.length() == 1) {
            apiId = matchedAPI[0].apiId;
            log:printInfo("API found" + apiId);
        }

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

        //store the urls of the paths
        store:APIAssets assets = {
            assetId: uuid:createType1AsString(),
            landingPageUrl: apiLandingPage,
            apiAssets: apiContent.apiAssets,
            assetmappingsApiId: apiId,
            stylesheets: apiContent.stylesheets,
            markdown: apiContent.markdown
        };

        log:printInfo("API Assets: " + apiContent.apiAssets.toString());

        string[] listResult = check adminClient->/apiassets.post([assets]);

        models:APIContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: apiContent
        };
        return uploadedContent;
    }

    resource function post api(@http:Payload models:ApiMetadata metadata) returns http:Response|error {
        final store:Client sClient = check new ();

        stream<store:OrganizationWithRelations, persist:Error?> organizations = adminClient->/organizations.get();

        //retrieve the organization id
        store:OrganizationWithRelations[] organization = check from var org in organizations
            where org.organizationName == metadata.apiInfo.orgName
            select org;

        string orgId = organization.pop().orgId ?: "";

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
            orgId: orgId,
            apiName: metadata.apiInfo.apiName,
            apiCategory: metadata.apiInfo.apiCategory,
            openApiDefinition: metadata.apiInfo.openApiDefinition,
            productionUrl: metadata.serverUrl.productionUrl,
            sandboxUrl: metadata.serverUrl.sandboxUrl,
            organizationName: metadata.apiInfo.orgName
        };

        string[] apiIDs = check sClient->/apimetadata.post([metadataRecord]);

        // //store the url of the api landing page
        // store:APIAssets assets = {
        //     assetId: uuid:createType1AsString(),
        //     landingPageUrl: metadata.apiInfo.apiLandingPageURL ?: "",
        //     apiAssets: [],
        //     assetmappingsApiId: apiIDs[0]
        // ,stylesheets: [], markdown: []};

        // string[] listResult = check adminClient->/apiassets.post([assets]);

        if (metadataRecord.length() > 0) {
            http:Response response = new;
            response.setPayload({apiId: apiIDs[0]});
            return response;
        }
        return error("Error occurred while adding the API metadata");
    }
}

