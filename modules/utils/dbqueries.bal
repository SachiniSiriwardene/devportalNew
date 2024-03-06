import devportal.models;
import devportal.store;

import ballerina/log;
import ballerina/log;
import ballerina/persist;
import ballerina/uuid;

final store:Client dbClient = check new ();

public function getOrgId(string orgName) returns string|error {

    stream<store:OrganizationWithRelations, persist:Error?> organizations = check dbClient->/organizations.get();

    //retrieve the organization id
    store:OrganizationWithRelations[] organization = check from var org in organizations
        where org.organizationName == orgName
        select org;

    if (organization.length() == 0) {
        return error("Organization not found");
    }

    return organization[0].orgId ?: "";

}

public function getOrgDetails(string orgName) returns store:OrganizationWithRelations|error {

    stream<store:OrganizationWithRelations, persist:Error?> organizations = check dbClient->/organizations.get();

    //retrieve the organization id
    store:OrganizationWithRelations[] organization = check from var org in organizations
        where org.organizationName == orgName
        select org;

    if (organization.length() == 0) {
        return error("Organization not found");
    }

    return organization[0];

}

public function getAPIId(string orgName, string apiName) returns string|error {

    string orgId = check getOrgId(orgName);
    stream<store:ApiMetadata, persist:Error?> apis = dbClient->/apimetadata.get();

    //retrieve the api id
    store:ApiMetadata[] matchedAPI = check from var api in apis
        where api.apiName == apiName && api.orgId == orgId
        select api;

    if (matchedAPI.length() == 0) {
        return error("API not found");
    }
    return matchedAPI[0].apiId;
}

public function createOrg(string orgName, string template) returns string|error {
    store:OrganizationInsert org = {
        orgId: uuid:createType1AsString(),
        organizationName: orgName,
        templateName: template,
        isDefault: true
    };

    //create an organization record
    string[] orgCreationResult = check dbClient->/organizations.post([org]);

    if (orgCreationResult.length() == 0) {
        return error("Organization creation failed");
    }
    return orgCreationResult[0];
}

public function updateOrg(string orgName, string template) returns string|error {

    string orgId = check getOrgId(orgName);

    store:Organization org = check dbClient->/organizations/[orgId].put({
        organizationName: orgName,
        templateName: template,
        isDefault: false
    });

    return org.orgId;
}

public function createOrgAssets(models:OrganizationAssets orgContent) returns string|error {

    store:OrganizationAssets assets = {
        assetId: uuid:createType1AsString(),
        orgLandingPage: orgContent.orgLandingPage,
        orgAssets: orgContent.orgAssets,
        organizationassetsOrgId: orgContent.orgId,
        markdown: orgContent.markdown,
        apiStyleSheet: orgContent.apiStyleSheet,
        orgStyleSheet: orgContent.orgStyleSheet,
        apiLandingPage: orgContent.apiLandingPage
    };

    string[] listResult = check dbClient->/organizationassets.post([assets]);

    log:printInfo("Asset ID update: " + listResult[0]);

    if (listResult.length() == 0) {
        return error("Organization assets creation failed");
    }
    return listResult[0];
}

public function updateOrgAssets(models:OrganizationAssets orgContent, string orgName) returns string|error {

    string orgId = check getOrgId(orgName);

    stream<store:OrganizationAssets, persist:Error?> orgAssets = dbClient->/organizationassets.get();

    //retrieve the api id
    store:OrganizationAssets[] asset = check from var orgAsset in orgAssets
        where orgAsset.organizationassetsOrgId == orgId
        select orgAsset;

    string assetID = asset.pop().assetId;
    log:printInfo("Asset ID update: " + assetID);

     store:OrganizationAssets org = check  dbClient->/organizationassets/[assetID].put({
        orgLandingPage: orgContent.landingPageUrl,
        orgAssets: orgContent.orgAssets,
        organizationassetsOrgId: orgId,
        apiStyleSheet: orgContent.apiStyleSheet,
        orgStyleSheet: orgContent.orgStyleSheet,
        apiLandingPage: orgContent.apiLandingPage
    });

    return org.assetId;
}


public function createAPIAssets(models:APIAssets apiContent) returns string|error {

    store:APIAssets assets = {
        assetId: uuid:createType1AsString(),
        apiAssets: apiContent.apiAssets,
        assetmappingsApiId: apiContent.apiId,
        stylesheet: apiContent.stylesheet,
        markdown: apiContent.markdown,
        landingPageUrl: apiContent.landingPageUrl
    };

    log:printInfo("Stored API asset ID "+apiContent.apiId);

    string[] listResult = check dbClient->/apiassets.post([assets]);

    if (listResult.length() == 0) {
        return error("API assets creation failed");
    }
    return listResult[0];
}

public function createAPI(models:ApiMetadata apiMetaData) returns string|error {

    models:ThrottlingPolicy[] throttlingPolicies = apiMetaData.throttlingPolicies ?: [];
    store:ThrottlingPolicy[] throttlingPolicyRecords = [];
    string apiID = apiMetaData.apiInfo.apiName;

    foreach var policy in throttlingPolicies {
        throttlingPolicyRecords.push({
            apimetadataApiId: apiID,
            policyId: uuid:createType1AsString(),
            'type: policy.'type,
            policyName: policy.policyName,
            description: policy.description
        });
    }

    if (throttlingPolicyRecords.length() != 0) {
        string[] propResults = check dbClient->/throttlingpolicies.post(throttlingPolicyRecords);
    }

    map<string> additionalProperties = apiMetaData.apiInfo.additionalProperties;
    store:AdditionalPropertiesInsert[] additionalPropertiesRecords = [];

    foreach var propertyKey in additionalProperties.keys() {
        additionalPropertiesRecords.push({
            apimetadataApiId: apiID,
            propertyId: uuid:createType1AsString(),
            'key: propertyKey,
            value: <string>additionalProperties.get(propertyKey)
            });
    }
    

    if (additionalPropertiesRecords.length() != 0) {
        string[] propResults = check dbClient->/additionalproperties.post(additionalPropertiesRecords);
    }

    map<string> apiContents = apiMetaData.apiInfo.apiArtifacts.apiContent;
    store:ApiContentInsert[] apiContent = [];

    foreach var propertyKey in apiContents.keys() {
        apiContent.push({
            apimetadataApiId: apiID,
            contentId: uuid:createType1AsString(),
            'key: propertyKey,
            value: <string>apiContents.get(propertyKey)
        });
    }

    if (apiContent.length() != 0) {
        string[] contentResults = check dbClient->/apicontents.post(apiContent);
    }

    map<string> apiImages = apiMetaData.apiInfo.apiArtifacts.apiImages;
    store:ApiImagesInsert[] apiImagesRecord = [];

    foreach var propertyKey in apiImages.keys() {
        apiImagesRecord.push({
            apimetadataApiId: apiID,
            imageId: uuid:createType1AsString(),
            'key: propertyKey,
            value: <string>apiImages.get(propertyKey)
        });
    }

    if (apiImages.length() != 0) {
        string[] contentResults = check dbClient->/apiimages.post(apiImagesRecord);
    }


    string orgId = check getOrgId(apiMetaData.apiInfo.orgName);
    store:ApiMetadata metadataRecord = {
        apiId: apiID,
        orgId: orgId,
        apiName: apiMetaData.apiInfo.apiName,
        apiCategory: apiMetaData.apiInfo.apiCategory,
        openApiDefinition: apiMetaData.apiInfo.openApiDefinition,
        productionUrl: apiMetaData.serverUrl.productionUrl,
        sandboxUrl: apiMetaData.serverUrl.sandboxUrl,
        organizationName: apiMetaData.apiInfo.orgName
    };

    string[] listResult = check dbClient->/apimetadata.post([metadataRecord]);


    if (listResult.length() == 0) {
        return error("API creation failed");
    }
    return listResult[0];
}
