import devportal.store;
import devportal.utils;

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
    resource function get [string orgName]/files/[string... paths](http:Request request) returns http:Response|error {

        store:OrganizationWithRelations orgDetails = check utils:getOrgDetails(orgName);

        store:OrganizationAssetsWithRelations orgAssets = orgDetails.organizationAssets ?: {};

        mime:Entity file = new;
        log:printInfo("./" + request.rawPath);

        do {
            // if (orgDetails.isDefault ?: false) {
            //     log:printInfo(regex:split(request.rawPath, "/files")[1]);
            //     file.setFileAsEntityBody("DefaultOrg/files" + regex:split(request.rawPath, "/files")[1]);
            // } else {

            //     boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);
            //     if (dirExists) {
            //         file.setFileAsEntityBody("." + request.rawPath);
            //     }
            // }
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
        return response;

    }

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


        string templateName = org.templateName ?: "";

        string landingPage = storedAsset.pop().orgLandingPage ?: "";
        log:printInfo("Landing page URL: " + landingPage);
        if (templateName.equalsIgnoreCaseAscii("custom")) {
            file.setFileAsEntityBody(orgName + "/" + landingPage);
        } else {
            file.setFileAsEntityBody(landingPage);
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

        string templateName = org.templateName ?: "";

        string orgId = org.orgId ?: "";

        stream<store:ApiMetadataWithRelations, persist:Error?> apis = retrieveContent->/apimetadata.get();

        //retrieve the organization id
        store:ApiMetadataWithRelations[] apiMetaData = check from var api in apis
            where api.apiName == apiName && api.orgId == orgId
            select api;
        store:ApiMetadataWithRelations api = apiMetaData.pop();
        log:printInfo("API data" + api.toString());
       
        string landingPage = org?.organizationAssets?.apiLandingPage ?: "";
        log:printInfo("Landing page URL: " + landingPage);
        if (templateName.equalsIgnoreCaseAscii("custom")) {
            file.setFileAsEntityBody(orgName + "/" + landingPage);
        } else {
            file.setFileAsEntityBody(landingPage);
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
        response.setHeader("Content-Disposition", "attachment; filename=" + landingPage);
        return response;
    }
}
