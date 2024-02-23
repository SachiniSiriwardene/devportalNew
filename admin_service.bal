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

    # Description.
    #
    # + orgName - parameter description
    # + return - return value description
    resource function post orgContent(string orgName) returns models:OrgContentResponse|error {

        string orgId = check utils:createOrg(orgName, "template1");
        models:OrganizationAssets assetMappings = {

            landingPageUrl: "templates/template1/org-landing-page.html",
            orgAssets: ["/files/OrgLandingPage/content/org-landing-page-section-one.md", 
                        "/files/OrgLandingPage/content/org-landing-page-section-three.md",
                        "/files/OrgLandingPage/content/org-landing-page-section-two.md"],
            orgId: orgId,
            markdown: ["/files/OrgLandingPage/content/org-landing-page-section-one.md", 
                        "/files/OrgLandingPage/content/org-landing-page-section-three.md",
                        "/files/OrgLandingPage/content/org-landing-page-section-two.md"],
            stylesheet: ""
        };

        string orgAssets = check utils:createOrgAssets(assetMappings);

        log:printInfo("Org assets created: " + orgAssets);

        models:OrgContentResponse uploadedContent = {
            timeUploaded: time:utcToString(time:utcNow(0)),
            assetMappings: assetMappings
        };
        return uploadedContent;

    }

    # Store the organization landing page content.
    #
    # + request - parameter description  
    # + orgName - parameter description  
    # + templateName - parameter description
    # + return - return value description
    resource function put orgContent(http:Request request, string orgName, string templateName) returns models:OrgContentResponse|error {

        byte[] binaryPayload = check request.getBinaryPayload();
        string path = "./zip";
        string targetPath = "./";
        check io:fileWriteBytes(path, binaryPayload);

        error? result = check zip:extract(path, targetPath);

        models:OrganizationAssets assetMappings = {

            landingPageUrl: "",
            orgAssets: [],
            orgId: "",
            markdown: [],
            stylesheet: ""
        };

        file:MetaData[] directories = check file:readDir("./" + orgName + "/files/OrgLandingPage");
        models:OrganizationAssets orgContent = check utils:getContentForOrgTemplate(directories, orgName, assetMappings);

        //check whether org exists
        string|error orgId = utils:getOrgId(orgName);
       
        string org = check utils:updateOrg(orgName, templateName);

        string landingPage = "";
        if (!templateName.equalsIgnoreCaseAscii("custom")) {
            file:MetaData[] & readonly readDir = check file:readDir("./templates/" + templateName);
            foreach var file in readDir {
                if (file.absPath.endsWith("org-landing-page.html")) {
                    orgContent.landingPageUrl = check file:relativePath(file:getCurrentDir(), file.absPath);
                }
            }
        }

        log:printInfo("Landing page content: " + landingPage);
        log:printInfo("Template name: " + templateName);

        string orgAssets = check utils:updateOrgAssets(orgContent, orgName);

        log:printInfo("Org assets created: " + orgAssets);

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

        string orgId = check utils:getOrgId(orgName);
        log:printInfo("Org ID: " + orgId);
        models:OrganizationAssets organizationAssets = {landingPageUrl: "", orgAssets: [], orgId: "", stylesheet: "", markdown: []};
        models:APIAssets apiAssetModel = {apiAssets: [], landingPageUrl: "", stylesheet: "", markdown: [], apiId: ""};
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
                    orgId: asset.organizationassetsOrgId ?: "",
                    stylesheet: asset.stylesheet ?: "",
                    markdown: asset.markdown ?: []
                };
            }
            return organizationAssets;
        } else {
            string apiID = check utils:getAPIId(orgName, apiName);

            stream<store:APIAssetsWithRelations, persist:Error?> apiAssets = adminClient->/apiassets.get();

            store:APIAssetsWithRelations[] assets = check from var asset in apiAssets
                where asset.assetmappingsApiId == apiID
                select asset;

            log:printInfo("API Assets" + assets.toString());

            foreach var asset in assets {
                apiAssetModel = {
                    apiAssets: asset.apiAssets ?: [],
                    landingPageUrl: asset.landingPageUrl ?: "",
                    stylesheet: asset.stylesheet ?: "",
                    markdown: asset.markdown ?: [],
                    apiId: asset.assetmappingsApiId ?: ""
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
        string orgId = check utils:getOrgId(theme.orgName);
        if (theme.templateName.equalsIgnoreCaseAscii("custom")) {
            log:printInfo("Custom theme selected");
            //store the url of tbe org landing page in the database
            store:OrganizationAssetsInsert assets = {
                assetId: uuid:createType1AsString(),
                orgLandingPage: theme.orgLandingPageUrl ?: "",
                organizationassetsOrgId: orgId,
                orgAssets: (),
                stylesheet: "",
                markdown: []
            };
            string[] listResult = check adminClient->/organizationassets.post([assets]);
        }

        //TODO :map the templacte name to ID 

        store:ThemeInsert insertTheme = {
            themeId: uuid:createType1AsString(),
            organizationOrgId: orgId,
            theme: theme.toJsonString()
        };

        string[] listResult = check adminClient->/themes.post([insertTheme]);

        models:ThemeResponse createdTheme = {
            createdAt: time:utcToString(time:utcNow(0)),
            themeId: listResult[0],
            orgId: orgId
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

