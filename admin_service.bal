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

// # A service representing a network-accessible API
// # bound to port `8080`.

final store:Client adminClient = check new ();

service /admin on new http:Listener(8080) {

    # Store the content for landing pages.
    #
    # + request - compressed file containing the folder content  
    # + orgName - organization name
    # + return - return value description
    // resource function post orgTemplate(http:Request request, string orgName) returns models:OrgContentResponse|error {

    //     byte[] binaryPayload = check request.getBinaryPayload();
    //     string path = "files/zip";
    //     string targetPath = "./files/unzip";
    //     check io:fileWriteBytes(path, binaryPayload);

    //     error? result = check zip:extract(path, targetPath);

    //     models:OrganizationAssets assetMappings = {

    //         landingPageUrl: "",
    //         orgAssets: [],
    //         orgId: ""
    //     };
    //     models:APIAssets[] apiAssets = [];

    //     file:MetaData[] directories = check file:readDir(targetPath);
    //     string[] readContentResult = check utils:readOrganizationContent(directories, file:getCurrentDir(), []);

    //     //store the urls of the paths
    //     store:OrganizationAssets assets = {
    //         assetId: uuid:createType1AsString(),
    //         orgLandingPage: assetMappings.landingPageUrl,
    //         orgAssets: readContentResult,
    //         organizationassetsOrgId: ""};

    //     string[] listResult = check adminClient->/organizationassets.post([assets]);

    //     assetMappings.orgId = listResult[0];
    //     assetMappings.orgAssets = readContentResult;
    //     store:OrganizationInsert org = {
    //         orgId: uuid:createType1AsString(),
    //         organizationName: orgName
    //     };

    //     string[] orgCreationResult = check adminClient->/organizations.post([org]);

    //     assetMappings.orgId = orgCreationResult[0];

    //     models:OrgContentResponse uploadedContent = {
    //         timeUploaded: time:utcToString(time:utcNow(0)),
    //         assetMappings: assetMappings
    //     };
    //     return uploadedContent;
    // }

    # Store the organization landing page content.
    # + return - return value description
    resource function post orgContent(http:Request request, string orgName) returns models:OrgContentResponse|error {

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./";
        check io:fileWriteBytes(path, binaryPayload);

        error? result = check zip:extract(path, targetPath);

        models:OrganizationAssets assetMappings = {

            landingPageUrl: "",
            orgAssets: [],
            orgId: ""
        };

        file:MetaData[] directories = check file:readDir(targetPath + "/" + orgName);
        models:OrganizationAssets orgContent = check utils:getContentForOrgTemplate(directories, orgName, assetMappings);

        stream<store:OrganizationWithRelations, persist:Error?> organizations = adminClient->/organizations.get();

        //retrieve the organization id
        store:OrganizationWithRelations[] organization = check from var org in organizations
            where org.organizationName == orgName
            select org;

        if (organization.length() == 0) {
            //create an organization record
            return error("Organization doesnt exist");
        }

        store:OrganizationWithRelations org = organization.pop();

        store:ThemeOptionalized[] theme = org.theme ?: [];

        string templateName = theme.pop().templateId ?: "";

        file:MetaData[] & readonly readDir = check file:readDir("./templates/" + templateName);
        string relativePath = check file:relativePath(file:getCurrentDir(), readDir[0].absPath);

        log:printInfo("Landing page content: " + relativePath);
        log:printInfo("Template name: " + templateName);

        orgContent.landingPageUrl = relativePath;

        //store the urls of the paths in the database
        store:OrganizationAssets assets = {
            assetId: uuid:createType1AsString(),
            orgLandingPage: relativePath + "org-landing-page.html",
            orgAssets: orgContent.orgAssets,
            organizationassetsOrgId: org.orgId ?: ""
        };

        string[] listResult = check adminClient->/organizationassets.post([assets]);

        models:OrgContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: orgContent
        };
        return uploadedContent;

    }

    # Get the asset paths for the org or api.
    #
    # + orgName - parameter description  
    # + apiName - parameter description
    # + return - return value description
    resource function get assets(string orgName, string? apiName) returns models:OrganizationAssets|models:APIAssets|error {

        stream<store:Organization, persist:Error?> organizations = adminClient->/organizations.get();

        //retrieve the organization id
        store:OrganizationWithRelations[] organization = check from var org in organizations
            where org.organizationName == orgName
            select org;

        if (organization.length() == 0) {
            //create an organization record
            return error("Organization doesnt exist");
        }

        string orgId = organization.pop().orgId ?: "";

        log:printInfo("Org ID: " + orgId);
        string apiID = "";
        models:OrganizationAssets organizationAssets = {landingPageUrl: "", orgAssets: [], orgId: ""};
        models:APIAssets apiAssetModel = {apiAssets: [], landingPageUrl: ""};
        if (apiName == null) {
            stream<store:OrganizationAssetsWithRelations, persist:Error?> orgAssets = adminClient->/organizationassets.get();

            store:OrganizationAssetsWithRelations[] assets = check from var asset in orgAssets
                where asset.organizationassetsOrgId == orgId
                select asset;
            
            log:printInfo("Assets" + assets.toString());

            foreach var asset in assets {
                organizationAssets = {
                    landingPageUrl: asset.orgLandingPage ?: "",
                    orgAssets: asset?.orgAssets ?: [],
                    orgId: asset.organizationassetsOrgId ?: ""
                };
            }
            return organizationAssets;
        } else {
            stream<store:ApiMetadata, persist:Error?> apis = adminClient->/apimetadata.get();

            store:ApiMetadata[] apiMetaData = check from var api in apis
                where api.orgId == orgId && api.apiName == apiName
                select api;

            apiID = apiMetaData.pop().apiId;

            stream<store:APIAssetsWithRelations, persist:Error?> apiAssets = adminClient->/apiassets.get();

            store:APIAssetsWithRelations[] assets = check from var asset in apiAssets
                where asset.assetmappingsApiId == apiID
                select asset;

            log:printInfo("API Assets" + assets.toString());


            foreach var asset in assets {
                apiAssetModel = {
                    apiAssets: asset.apiAssets ?: [],
                    landingPageUrl: asset.landingPageUrl ?: ""
                };
            }
            return apiAssetModel;
        }
    }

    # Store the theme for the developer portal.
    #
    # + theme - theme object
    # + return - return value description
    resource function post theme(@http:Payload models:Theme theme) returns models:ThemeResponse|error {

        stream<store:Organization, persist:Error?> organizations = adminClient->/organizations.get();

        //retrieve the organization id
        store:Organization[] organization = check from var org in organizations
            where org.organizationName == theme.orgName
            select org;

        if (organization.length() != 0) {
            //create an organization record
            return error("Organization already exists");
        }

        //TODO retrieve the organization id for the organization name
        store:OrganizationInsert org = {
            orgId: uuid:createType1AsString(),
            organizationName: theme.orgName
        };

        //create an organization record
        string[] orgCreationResult = check adminClient->/organizations.post([org]);

        log:printInfo("Organization created with id: " + orgCreationResult[0]);

        if (theme.templateName.equalsIgnoreCaseAscii("custom")) {
            log:printInfo("Custom theme selected");
            //store the url of tbe org landing page in the database
            store:OrganizationAssetsInsert assets = {
                assetId: orgCreationResult[0],
                orgLandingPage: theme.orgLandingPageUrl ?: "",
                organizationassetsOrgId: orgCreationResult[0],
                orgAssets: ()
            };

            string[] listResult = check adminClient->/organizationassets.post([assets]);
        }

        //TODO :map the templacte name to ID 

        store:ThemeInsert insertTheme = {
            themeId: uuid:createType1AsString(),
            templateId: theme.templateName,
            organizationOrgId: orgCreationResult[0],
            theme: theme.toJsonString()
        };

        string[] listResult = check adminClient->/themes.post([insertTheme]);

        models:ThemeResponse createdTheme = {
            createdAt: time:utcToString(time:utcNow(0)),
            themeId: listResult[0],
            orgId: orgCreationResult[0]
        };
        return createdTheme;
    }

    # Store the identity provider details for the developer portal.
    #
    # + identityProvider - IDP details
    # + return - return value description
    resource function post identityProvider(@http:Payload models:IdentityProvider identityProvider) returns models:IdentityProviderResponse|error {

        store:IdentityProviderInsert idp = {
            idpID: uuid:createType1AsString(),
            name: identityProvider.name,
            envrionments: identityProvider.envrionments,
            jwksEndpoint: identityProvider.jwksEndpoint,
            introspectionEndpoint: identityProvider.introspectionEndpoint,
            wellKnownEndpoint: identityProvider.wellKnownEndpoint,
            authorizeEndpoint: identityProvider.authorizeEndpoint,
            issuer: identityProvider.issuer,
            organizationOrgId: identityProvider.orgId
        };

        string[] listResult = check adminClient->/identityproviders.post([idp]);

        models:IdentityProviderResponse createdIDP = {createdAt: "", idpName: identityProvider.name, id: listResult[0]};
        return createdIDP;
    }

    # Retrieve identity providers.
    #
    # + orgId - parameter description
    # + return - list of identity providers for the organization.
    resource function get identityProvider(string orgId) returns models:IdentityProvider[]|error {

        stream<store:IdentityProviderWithRelations, persist:Error?> identityProviders = adminClient->/identityproviders.get();
        store:IdentityProviderWithRelations[] idpList = check from var idp in identityProviders
            select idp;
        models:IdentityProvider[] idps = [];

        foreach var idp in idpList {
            string idpOrgId = idp.organizationOrgId ?: "";
            if (orgId.equalsIgnoreCaseAscii(idpOrgId)) {

                models:IdentityProvider identityProvider = {
                    name: idp.name ?: "",
                    envrionments: idp.envrionments ?: [],
                    jwksEndpoint: idp.jwksEndpoint ?: "",
                    introspectionEndpoint: idp.introspectionEndpoint ?: "",
                    wellKnownEndpoint: idp.wellKnownEndpoint ?: "",
                    authorizeEndpoint: idp.authorizeEndpoint ?: "",
                    issuer: idp.issuer ?: "",
                    orgId: idp.organizationOrgId ?: ""
                };
                idps.push(identityProvider);
            }

        }
        return idps;
    }
}

