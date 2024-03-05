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

        boolean dirExists = check file:test("." + request.rawPath, file:EXISTS);

        if (dirExists) {
            file:Error? remove = check file:remove(orgName);

        }

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

        apiContent.apiId = apiId;

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
}

