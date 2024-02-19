import devportal.models;
import devportal.store;
import devportal.utils;

import ballerina/file;
import ballerina/http;
import ballerina/io;
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
    resource function post orgContent(http:Request request, string orgName, string templateName) returns models:OrgContentResponse|error {

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "files/zip";
        string targetPath = "./files/unzip";
        check io:fileWriteBytes(path, binaryPayload);

        error? result = check zip:extract(path, targetPath);

        models:OrganizationAssets assetMappings = {

            landingPageUrl: "",
            orgAssets: [],
            orgId: ""
        };

        file:MetaData[] directories = check file:readDir(targetPath);
        models:OrganizationAssets orgContent = check utils:getContentForOrgTemplate(directories, file:getCurrentDir(), assetMappings, templateName);

        //TODO retrieve the organization id for the organization name
        store:OrganizationInsert org = {
            orgId: uuid:createType1AsString(),
            organizationName: orgName
        };

        //create an organization record
        string[] orgCreationResult = check adminClient->/organizations.post([org]);

        orgContent.orgId = orgCreationResult[0];

        file:MetaData[] & readonly readDir = check file:readDir("./templates/" + templateName + "/org-landing-page.html");

        //store the urls of the paths in the database
        store:OrganizationAssets assets = {
            assetId: orgCreationResult[0],
            orgLandingPage: readDir[0].absPath,
            orgAssets: orgContent.orgAssets,
            organizationassetsOrgId: orgContent.orgId
        };

        string[] listResult = check adminClient->/organizationassets.post([assets]);

        models:OrgContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: orgContent
        };
        return uploadedContent;

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

        //TODO retrieve the organization id for the organization name
        store:OrganizationInsert org = {
            orgId: uuid:createType1AsString(),
            organizationName: theme.orgName
        };

        //create an organization record
        string[] orgCreationResult = check adminClient->/organizations.post([org]);

        if (theme.templateName.equalsIgnoreCaseAscii("custom")) {
            //store the url of tbe org landing page in the database
            store:OrganizationAssetsInsert assets = {
                assetId: orgCreationResult[0],
                orgLandingPage: theme.orgLandingPageUrl,
                organizationassetsOrgId: orgCreationResult[0],
                orgAssets: ()
            };

            string[] listResult = check adminClient->/organizationassets.post([assets]);
        }

        //TODO :map the templacte name to ID 

        store:ThemeInsert insertTheme = {
            themeId: uuid:createType1AsString(),
            templateId: theme.templateName,
            organizationOrgId: organization[0].orgId,
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

