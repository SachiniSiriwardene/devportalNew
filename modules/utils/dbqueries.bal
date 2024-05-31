import devportal.models;
import devportal.store;

import ballerina/log;
import ballerina/persist;
import ballerina/uuid;

final store:Client dbClient = check new ();

public function getOrgId(string orgName) returns string|error {

    stream<store:Organization, persist:Error?> organizations = check dbClient->/organizations.get();

    //retrieve the organization id
    store:Organization[] organization = check from var org in organizations
        where org.organizationName == orgName
        select org;

    if (organization.length() == 0) {
        return error("Organization not found");
    }

    return organization[0].orgId;

}

public function getOrgName(string orgId) returns string|error {

    store:Organization organization = check dbClient->/organizations/[orgId];
    return organization.organizationName;

}

public function getOrgDetails(string orgName) returns store:OrganizationWithRelations|error {

    stream<store:Organization, persist:Error?> organizations = check dbClient->/organizations.get();

    //retrieve the organization id
    store:Organization[] organization = check from var org in organizations
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

public function createOrg(models:Organization organization) returns string|error {

    string[] authenticaedPages = organization.authenticatedPages ?: [];
    string pages = string:'join(" ", ...authenticaedPages);

    store:OrganizationInsert org = {
        orgId: uuid:createType1AsString(),
        organizationName: organization.orgName,
        templateName: organization.templateName,
        isPublic: organization.isPublic,
        authenticatedPages: pages
    };

    //create an organization record
    string[] orgCreationResult = check dbClient->/organizations.post([org]);

    if (orgCreationResult.length() == 0) {
        return error("Organization creation failed");
    }
    return orgCreationResult[0];
}

public function updateOrg(models:Organization organization) returns string|error {

    string orgId = check getOrgId(organization.orgName);
    string[] authenticaedPages = organization.authenticatedPages ?: [];
    string pages = string:'join(" ", ...authenticaedPages);

    store:Organization org = check dbClient->/organizations/[orgId].put({
        organizationName: organization.orgName,
        templateName: organization.templateName,
        isPublic: organization.isPublic,
        authenticatedPages: pages
    });

    return org.orgId;
}

public function createOrgAssets(models:OrganizationAssets[] orgContent) returns string|error {

    store:OrganizationAssets[] orgAssets = [];
    foreach var asset in orgContent {
        store:OrganizationAssets storeAsset = {
            pageType: asset.pageType,
            pageContent: asset.pageContent,
            organizationOrgId: asset.orgId
        };
        orgAssets.push(storeAsset);
    }

    string[] listResult = check dbClient->/organizationassets.post(orgAssets);

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
        where orgAsset.organizationOrgId == orgId
        select orgAsset;

    string assetID = asset.pop().pageType;
    log:printInfo("Asset ID update: " + assetID);

    store:OrganizationAssets org = check dbClient->/organizationassets/[assetID].put({
        organizationOrgId: orgId,
        pageType: orgContent.pageType,
        pageContent: orgContent.pageContent
    });

    return org.pageType;
}

public function createAPIMetadata(models:ApiMetadata apiMetaData) returns string|error {

    string roles = "";
    if (apiMetaData.apiInfo.hasKey("authorizedRoles")) {

        string[] authenticatedRoles = apiMetaData.apiInfo.authorizedRoles ?: [];
        roles = string:'join(" ", ...authenticatedRoles);
    }

    string apiID = apiMetaData.apiInfo.apiName;
    string orgName = apiMetaData.apiInfo.orgName;
    string orgId = check getOrgId(apiMetaData.apiInfo.orgName);
    json metadata = {
        apiName: apiMetaData.apiInfo.apiName,
        apiCategory: apiMetaData.apiInfo.apiCategory,
        openApiDefinition: apiMetaData.apiInfo.openApiDefinition.toJson(),
        productionUrl: apiMetaData.serverUrl.productionUrl,
        sandboxUrl: apiMetaData.serverUrl.sandboxUrl
    };
    store:ApiMetadata metadataRecord = {
        apiId: apiID,
        orgId: orgId,
        apiName: apiMetaData.apiInfo.apiName,
        metadata: metadata.toJsonString(),
        apiCategory: apiMetaData.apiInfo.apiCategory,
        openApiDefinition: apiMetaData.apiInfo.openApiDefinition.toJsonString(),
        productionUrl: apiMetaData.serverUrl.productionUrl,
        sandboxUrl: apiMetaData.serverUrl.sandboxUrl,
        organizationName: apiMetaData.apiInfo.orgName,
        authorizedRoles: roles
    };

    string[][] listResult = check dbClient->/apimetadata.post([metadataRecord]);

    addAdditionalProperties(apiMetaData.apiInfo.additionalProperties, apiID, orgName);
    addThrottlingPolicy(apiMetaData.throttlingPolicies ?: [], apiID, orgName);

    if (listResult.length() == 0) {
        return error("API creation failed");
    }
    return listResult[0][0];
}

public function updateAPIMetadata(models:ApiMetadata apiMetaData, string apiID, string orgName) returns string|error {
    addThrottlingPolicy(apiMetaData.throttlingPolicies ?: [], apiID, orgName);
    addAdditionalProperties(apiMetaData.apiInfo.additionalProperties, apiID, orgName);

    string roles = "";
    if (apiMetaData.apiInfo.hasKey("authorizedRoles")) {

        string[] authenticatedRoles = apiMetaData.apiInfo.authorizedRoles ?: [];
        roles = string:'join(" ", ...authenticatedRoles);
    }
    string orgId = check getOrgId(apiMetaData.apiInfo.orgName);
    store:ApiMetadataUpdate metadataRecord = {
        orgId: orgId,
        apiName: apiMetaData.apiInfo.apiName,
        apiCategory: apiMetaData.apiInfo.apiCategory,
        openApiDefinition: apiMetaData.apiInfo.openApiDefinition.toJsonString(),
        productionUrl: apiMetaData.serverUrl.productionUrl,
        sandboxUrl: apiMetaData.serverUrl.sandboxUrl,
        authorizedRoles: roles
    };

    store:ApiMetadata listResult = check dbClient->/apimetadata/[apiID]/[orgName].put(metadataRecord);

    if (listResult.length() == 0) {
        return error("API metadata update failed");
    }
    return listResult.apiId;
}

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

    apiContentRecord.push({
        apimetadataApiId: apiID,
        contentId: uuid:createType1AsString(),
        apimetadataOrganizationName: orgName,
        apiContent: apiAssets.apiContent
    });

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

public function updateApiImages(models:APIImages[] imageRecords, string apiID, string orgName) returns string|error {

    foreach var apiImage in imageRecords {
        stream<store:ApiImages, persist:Error?> apiImages = dbClient->/apiimages.get();

        //retrieve the api id
        store:ApiImages[] images = check from var image in apiImages
            where image.apimetadataApiId == apiID && image.value == apiImage.imageName && image.apimetadataOrganizationName == orgName
            select image;
        if (images.length() !== 0) {
            store:ApiImages imageRecord = images[0];
            _ = check dbClient->/apiimages/[imageRecord.imageId].put({
                image: apiImage.image
            }
            );
        }
    }
    return "API Image upload success";
}

public function storeOrgImages(models:OrgImages[] orgImages, string orgId) returns string|error {

    store:OrgImagesInsert[] orgImageRecords = [];
    foreach var image in orgImages {
        orgImageRecords.push({
            fileName: image.imageName,
            image: image.image,
            imageId: uuid:createType1AsString(),
            organizationOrgId: orgId
        });
    }
    string[] listResult = check dbClient->/orgimages.post(orgImageRecords);
    log:printInfo("Organization images stored");

    if (listResult.length() == 0) {
        return error("Organization image creation failed");
    }
    return listResult[0];
}

public function retrieveAPIImages(string imagePath, string apiID, string orgName) returns byte[]|error {

    stream<store:ApiImages, persist:Error?> apiImages = dbClient->/apiimages.get();
    byte[] retrievedImage = [];
    string filePath = "/resources/images/" + imagePath;
    store:ApiImages[] images = check from var image in apiImages
        where image.apimetadataApiId == apiID && image.value == filePath && image.apimetadataOrganizationName == orgName
        select image;
    if (images.length() !== 0) {
        store:ApiImages imageRecord = images[0];
        retrievedImage = imageRecord.image ?: [];
    }
    return retrievedImage;
}

public function deleteAPI(string apiID, string orgName) returns string|error? {

    // store:ApiMetadata apiImages = check dbClient->/additionalproperties/["path"].delete;

    store:ApiMetadata apiImages = check dbClient->/apimetadata/[apiID]/[orgName].delete();

    return "API deleted successfully";

}

public function retrieveOrgFiles(string fileName, string orgId) returns store:OrganizationAssets[]|error? {

    stream<store:OrganizationAssets, persist:Error?> orgContent = dbClient->/organizationassets.get();
    store:OrganizationAssets[] contents = check from var content in orgContent
        where content.organizationOrgId == orgId && content.pageType == fileName
        select content;
    return  contents;
}

public function retrieveOrgImages(string fileName, string orgId) returns store:OrgImages[]|error? {

    stream<store:OrgImages, persist:Error?> orgContent = dbClient->/orgimages.get();
    store:OrgImages[] contents = check from var content in orgContent
        where content.organizationOrgId == orgId && content.fileName == fileName
        select content;
    return  contents;
}

public function addIdentityProvider(models:IdentityProvider identityProvider) returns string|error {

    string orgId = check getOrgId(identityProvider.orgName);
    store:IdentityProviderInsert idp = {
        organizationOrgId: orgId,
        idpID: uuid:createType1AsString(),
        name: identityProvider.name,
        issuer: identityProvider.issuer,
        clientId: identityProvider.clientId,
        clientSecret: identityProvider.clientSecret,
        id: identityProvider.id,
        'type: identityProvider.'type
    };
    string[] listResult = check dbClient->/identityproviders.post([idp]);
    return listResult[0];
}

public function getIdentityProviders(string orgName) returns store:IdentityProviderWithRelations[]|error {

    string orgId = check getOrgId(orgName);

    stream<store:IdentityProviderWithRelations, persist:Error?> identityProviders = dbClient->/identityproviders.get();
    store:IdentityProviderWithRelations[] idpList = check from var idp in identityProviders
        where idp.organizationOrgId == orgId
        select idp;
    return idpList;
}
