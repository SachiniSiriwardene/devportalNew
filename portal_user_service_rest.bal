import devportal.store;

import ballerina/file;
import ballerina/http;
import ballerina/log;
import ballerina/mime;
import ballerina/persist;

final store:Client retrieveContent = check new ();

service / on new http:Listener(3001) {

    # Retrieve organization template file.
    #
    # + orgName - parameter description  
    # + paths - parameter description  
    # + request - parameter description
    # + return - return value descriptio
    resource function get [string orgName]/files/[string ... paths](http:Request request) returns http:Response {

        mime:Entity file = new;
        log:printInfo("./" + request.rawPath);

        do {
            boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);
            if (dirExists) {
                file.setFileAsEntityBody("." + request.rawPath);
            }
        } on fail var e {
            log:printError("Error occurred while checking file existence: " + e.message());
        }
        
        http:Response response = new;
        response.setEntity(file);
        do {
            check response.setContentType("application/octet-stream");
        } on fail var e {
            log:printError("Error occurred while setting content type: " + e.message());
        }
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        //response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        return response;

    }

    // # Retrieve organization template file.
    // #
    // # + orgName - parameter description  
    // # + folder - parameter description  
    // # + page - parameter description  
    // # + fileName - parameter description  
    // # + request - parameter description
    // # + return - return value description
    // resource function get [string orgName]/files/[string folder]/[string page]/[string fileName](http:Request request) returns http:Response {

    //     mime:Entity file = new;
    //     log:printInfo("./" + request.rawPath);

    //     do {
    //         boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);
    //         if (dirExists) {
    //             file.setFileAsEntityBody("." + request.rawPath);
    //         }
    //     } on fail var e {
    //         log:printError("Error occurred while checking file existence: " + e.message());
    //     }

    //     log:printInfo("Bingo");
    //     http:Response response = new;
    //     response.setEntity(file);
    //     do {
    //         check response.setContentType("application/octet-stream");
    //     } on fail var e {
    //         log:printError("Error occurred while setting content type: " + e.message());
    //     }
    //     response.setHeader("Content-Type", "application/octet-stream");
    //     response.setHeader("Content-Description", "File Transfer");
    //     response.setHeader("Transfer-Encoding", "chunked");
    //     response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
    //     return response;

    // }

    resource function get orgTemplate(string orgName) returns http:Response|error {

        mime:Entity file = new;
        stream<store:OrganizationWithRelations, persist:Error?> organizations = retrieveContent->/organizations.get();

        stream<store:OrganizationAssetsWithRelations, persist:Error?> orgAssets = retrieveContent->/organizationassets.get();

        //retrieve the organization id
        store:OrganizationWithRelations[] organization = check from var org in organizations
            where org.organizationName == orgName
            select org;
        store:OrganizationWithRelations org = organization.pop();

        store:OrganizationAssetsWithRelations[] storedAsset = check from var asset in orgAssets
            where asset.organizationassetsOrgId == org.orgId
            select asset;

        store:ThemeOptionalized[] theme = org.theme ?: [];

        string templateName = theme.pop().templateId ?: "";

        if (templateName.equalsIgnoreCaseAscii("custom")) {
            string landingPage = storedAsset.pop().orgLandingPage ?: "";
            http:Client content = check new (landingPage);
            http:Response customOrgLandingPage = check content->get("");
            string orgLandingPage = check customOrgLandingPage.getTextPayload();
            file.setBody(orgLandingPage);
        } else {
            do {
                boolean dirExists = check file:test("./templates/" + templateName, file:EXISTS);
                if (dirExists) {
                    file.setFileAsEntityBody("./templates/" + templateName + "/org-landing-page.html");
                }
            } on fail var e {
                log:printError("Error occurred while checking file existence: " + e.message());
            }
        }

        http:Response response = new;
        response.setEntity(file);
        do {
            check response.setContentType("application/octet-stream");
        } on fail var e {
            log:printError("Error occurred while setting content type: " + e.message());
        }
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + templateName + "/org-landing-page.html");
        return response;
    }

    resource function get apiTemplate(string apiName, string orgName) returns http:Response|error {

        mime:Entity file = new;

        stream<store:OrganizationWithRelations, persist:Error?> organizations = retrieveContent->/organizations.get();

        //retrieve the organization id
        store:OrganizationWithRelations[] organization = check from var org in organizations
            where org.organizationName == orgName
            select org;

        store:OrganizationWithRelations org = organization.pop();

        store:ThemeOptionalized[] theme = org.theme ?: [];

        string templateName = theme.pop().templateId ?: "";

        string orgId = org.orgId ?: "";

        stream<store:ApiMetadataWithRelations, persist:Error?> apis = retrieveContent->/apimetadata.get();

        stream<store:APIAssetsWithRelations, persist:Error?> apiAssets = retrieveContent->/apiassets.get();

        //retrieve the organization id
        store:ApiMetadataWithRelations[] apiMetaData = check from var api in apis
            where api.apiName == apiName && api.orgId == orgId
            select api;

        //retrieve the organization id
        store:APIAssetsWithRelations[] assets = check from var asset in apiAssets
            where asset.assetmappingsApiId == apiMetaData.pop().apiId
            select asset;

        if (templateName.equalsIgnoreCaseAscii("custom")) {
            string landingPage = assets.pop().landingPageUrl ?: "";
            log:printInfo("Landing page URL: " + landingPage);
            http:Client content = check new (landingPage);
            http:Response customAPILandingPage = check content->get("");
            string apiLandingPage = check customAPILandingPage.getTextPayload();
            file.setBody(apiLandingPage);
        } else {
            do {
                boolean dirExists = check file:test("./templates/" + templateName, file:EXISTS);
                if (dirExists) {
                    file.setFileAsEntityBody("./templates/" + templateName + "/api-landing-page.html");
                }
            } on fail var e {
                log:printError("Error occurred while checking file existence: " + e.message());
            }
        }

        http:Response response = new;
        response.setEntity(file);
        do {
            check response.setContentType("application/octet-stream");
        } on fail var e {
            log:printError("Error occurred while setting content type: " + e.message());
        }
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Description", "File Transfer");
        response.setHeader("Transfer-Encoding", "chunked");
        response.setHeader("Content-Disposition", "attachment; filename=" + templateName + "/org-landing-page.html");
        return response;
    }
}
