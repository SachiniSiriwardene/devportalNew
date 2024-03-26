import devportal.models;
import devportal.store;

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

public function getAPIImages(string orgName, string apiName) returns store:ApiImages[]|error {

    string apiId = check getAPIId(orgName, apiName);
    stream<store:ApiImages, persist:Error?> apiImages = dbClient->/apiimages.get();

    //retrieve the api id
    store:ApiImages[] images = check from var image in apiImages
        where image.apimetadataApiId == apiId
        select image;

    if (images.length() == 0) {
        return error("API image record not found");
    }
    return images;
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

    store:OrganizationAssets org = check dbClient->/organizationassets/[assetID].put({
        orgLandingPage: orgContent.orgLandingPage,
        orgAssets: orgContent.orgAssets,
        organizationassetsOrgId: orgId,
        apiStyleSheet: orgContent.apiStyleSheet,
        orgStyleSheet: orgContent.orgStyleSheet,
        apiLandingPage: orgContent.apiLandingPage
    });

    return org.assetId;
}

public function createAPIMetadata(models:ApiMetadata apiMetaData) returns string|error {
    string apiID = apiMetaData.apiInfo.apiName;
    string orgName = apiMetaData.apiInfo.orgName;

    addThrottlingPolicy(apiMetaData.throttlingPolicies ?: [], apiID, orgName);
    addAdditionalProperties(apiMetaData.apiInfo.additionalProperties, apiID, orgName);

    string orgId = check getOrgId(apiMetaData.apiInfo.orgName);
    store:ApiMetadata metadataRecord = {
        apiId: apiID,
        orgId: orgId,
        apiName: apiMetaData.apiInfo.apiName,
        apiCategory: apiMetaData.apiInfo.apiCategory,
        openApiDefinition: apiMetaData.apiInfo.openApiDefinition.toJsonString(),
        productionUrl: apiMetaData.serverUrl.productionUrl,
        sandboxUrl: apiMetaData.serverUrl.sandboxUrl,
        organizationName: apiMetaData.apiInfo.orgName
    };

    string[][] listResult = check dbClient->/apimetadata.post([metadataRecord]);

    if (listResult.length() == 0) {
        return error("API creation failed");
    }
    return listResult[0][0];
}

public function updateAPIMetadata(models:ApiMetadata apiMetaData, string apiID, string orgName) returns string|error {
    addThrottlingPolicy(apiMetaData.throttlingPolicies ?: [], apiID, orgName);
    addAdditionalProperties(apiMetaData.apiInfo.additionalProperties, apiID, orgName);

    string orgId = check getOrgId(apiMetaData.apiInfo.orgName);
    store:ApiMetadataUpdate metadataRecord = {
        orgId: orgId,
        apiName: apiMetaData.apiInfo.apiName,
        apiCategory: apiMetaData.apiInfo.apiCategory,
        openApiDefinition: apiMetaData.apiInfo.openApiDefinition.toJsonString(),
        productionUrl: apiMetaData.serverUrl.productionUrl,
        sandboxUrl: apiMetaData.serverUrl.sandboxUrl
    };

    store:ApiMetadata listResult = check dbClient->/apimetadata/[apiID]/[orgName].put(metadataRecord);

    if (listResult.length() == 0) {
        return error("API metadata update failed");
    }
    return listResult.apiId;
}

// public function updateAPIImages(models:APIAssets assets, string apiName, string orgName) returns string|error {

//     store:ApiImages[] aPIImages = check getAPIImages(orgName, apiName);
//     string[] uploadedImages = assets.apiImages;
//     store:ApiImages[] updatedImages = [];

//     // replace the image path references with the uploaded image names
//     foreach var apiImage in uploadedImages {
//         foreach var image in aPIImages {
//             if (apiImage.includes(image.value)) {
//                 store:ApiImages updatedImage = {
//                     apimetadataApiId: image.apimetadataApiId, 
//                     imageId: image.imageId, 
//                     apimetadataOrganizationName: image.apimetadataOrganizationName, 
//                     'key: image.key, 
//                     value: apiImage
//                 };
//                 updatedImages.push(updatedImage);
//             } 
//         }
//     }

//      foreach var item in updatedImages {
//          store:ApiImages org = check dbClient->/apiimages/[item.apimetadataApiId].put({
//         orgLandingPage: orgContent.orgLandingPage,
//         orgAssets: orgContent.orgAssets,
//         organizationassetsOrgId: orgId,
//         apiStyleSheet: orgContent.apiStyleSheet,
//         orgStyleSheet: orgContent.orgStyleSheet,
//         apiLandingPage: orgContent.apiLandingPage
//     });
//      }
    

// }

public function addThrottlingPolicy(models:ThrottlingPolicy[] throttlingPolicies, string apiID, string orgName) {
    store:ThrottlingPolicy[] throttlingPolicyRecords = [];
    foreach var policy in throttlingPolicies {
        throttlingPolicyRecords.push({
            apimetadataApiId: apiID,
            policyId: uuid:createType1AsString(),
            'type: policy.'type,
            policyName: policy.policyName,
            description: policy.description,
            apimetadataOrganizationName: orgName
        });
    }

    if (throttlingPolicyRecords.length() != 0) {
        do {
            string[] propResults = check dbClient->/throttlingpolicies.post(throttlingPolicyRecords);
        } on fail var e {
            log:printError("Error occurred while adding throttling policies: " + e.message());
        }
    }
}

public function addAdditionalProperties(map<string> additionalProperties, string apiID, string orgName) {
    store:AdditionalPropertiesInsert[] additionalPropertiesRecords = [];

    foreach var propertyKey in additionalProperties.keys() {
        additionalPropertiesRecords.push({
            apimetadataApiId: apiID,
            propertyId: uuid:createType1AsString(),
            'key: propertyKey,
            value: <string>additionalProperties.get(propertyKey),
            apimetadataOrganizationName: orgName
        });
    }
    if (additionalPropertiesRecords.length() != 0) {
        do {
            string[] propResults = check dbClient->/additionalproperties.post(additionalPropertiesRecords);
        } on fail var e {
            log:printError("Error occurred while adding additional properties: " + e.message());
        }
    }
}

public function addApiContent(models:APIAssets apiAssets, string apiID, string orgName) {
    store:ApiContentInsert[] apiContentRecord = [];

    foreach var contentRef in apiAssets.apiContent {
        apiContentRecord.push({
            apimetadataApiId: apiID,
            contentId: uuid:createType1AsString(),
            apimetadataOrganizationName: orgName,
            apiContentReference: contentRef
        });
    }

    if (apiContentRecord.length() != 0) {
        do {
            string[] contentResults = check dbClient->/apicontents.post(apiContentRecord);
        } on fail var e {
            log:printError("Error occurred while adding API content: " + e.message());
        }
    }
}

public function addApiImages(map<string> images, string apiID, string orgName) {
    store:ApiImagesInsert[] apiImagesRecord = [];

    foreach var propertyKey in images.keys() {
        apiImagesRecord.push({
            apimetadataApiId: apiID,
            imageId: uuid:createType1AsString(),
            'key: propertyKey,
            value: <string>images.get(propertyKey),
            apimetadataOrganizationName: orgName
        });
    }
    if (apiImagesRecord.length() != 0) {
        do {
            string[] contentResults = check dbClient->/apiimages.post(apiImagesRecord);
        } on fail var e {
            log:printError("Error occurred while adding API images: " + e.message());
        }
    }
}
