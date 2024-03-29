import devportal.models;

import ballerina/file;
import ballerina/log;
import ballerina/mime;
import ballerina/regex;
import ballerina/io;

public function handleContent(mime:Entity bodyPart) {
    // Get the media type from the body part retrieved from the request.
    var mediaType = mime:getMediaType(bodyPart.getContentType());
    if mediaType is mime:MediaType {
        string baseType = mediaType.getBaseType();
        if mime:APPLICATION_XML == baseType || mime:TEXT_XML == baseType {
            var payload = bodyPart.getXml();
            if payload is xml {
                log:printInfo(payload.toString());
            } else {
                log:printError(payload.message());
            }
        } else if mime:APPLICATION_JSON == baseType {
            var payload = bodyPart.getJson();
            if payload is json {
                log:printInfo(payload.toJsonString());
            } else {
                log:printError(payload.message());
            }
        } else if mime:TEXT_PLAIN == baseType {
            var payload = bodyPart.getText();
            if payload is string {
                log:printInfo(payload);
            } else {
                log:printError(payload.message());
            }
        }
    }
}

public function readOrganizationContent(file:MetaData[] directories, string path, string[] assetMappings) returns string[]|error {

    foreach var item in directories {
        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check readOrganizationContent(meta, path, assetMappings);
        } else {
            string relativePath = check file:relativePath(file:getCurrentDir(), item.absPath);

            if (relativePath.endsWith(".html")) {
                if (relativePath.endsWith("org-landing-page.html")) {
                    assetMappings.push(relativePath);
                }
                if (relativePath.endsWith("api-landing-page.html")) {
                    assetMappings.push(relativePath);
                }
                assetMappings.push(relativePath);
            } else if (relativePath.endsWith(".css")) {
                assetMappings.push(relativePath);

            } else if (relativePath.endsWith(".mp4") || relativePath.endsWith(".webm") || relativePath.endsWith(".ogv")) {
                assetMappings.push(relativePath);

            } else if (relativePath.endsWith(".png") || relativePath.endsWith(".jpg") || relativePath.endsWith(".jpeg") ||
            relativePath.endsWith(".gif") || relativePath.endsWith(".svg") || relativePath.endsWith(".ico") || relativePath.endsWith(".webp")) {
                assetMappings.push(relativePath);
            }
        }
    }
    return assetMappings;
}

public function getContentForOrgTemplate(file:MetaData[] directories, string orgName, models:OrganizationAssets assetMappings)
returns models:OrganizationAssets|error {

    foreach var item in directories {
        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check getContentForOrgTemplate(meta, orgName, assetMappings);
        } else {
            string readContent = check io:fileReadString(item.absPath);
            log:printInfo(readContent);
            string[] names = regex:split(item.absPath, orgName);
            string relativePath = names[1];
            if (relativePath.endsWith(".md")) {
               
            } else if (relativePath.endsWith("org-landing-page.css")) {
                assetMappings.orgStyleSheet = readContent;

            } else if (relativePath.endsWith("api-landing-page.css")) {
                assetMappings.apiStyleSheet = readContent;

            }  else if (relativePath.endsWith("style.css")) {
                assetMappings.portalStyleSheet = readContent;

            } else if (relativePath.endsWith(".mp4") || relativePath.endsWith(".webm") || relativePath.endsWith(".ogv")) {
                assetMappings.orgAssets =  assetMappings.orgAssets + " " + relativePath;

            } else if (relativePath.endsWith(".png") || relativePath.endsWith(".jpg") || relativePath.endsWith(".jpeg") ||
            relativePath.endsWith(".gif") || relativePath.endsWith(".svg") || relativePath.endsWith(".ico") || relativePath.endsWith(".webp")) {

                assetMappings.orgAssets =  assetMappings.orgAssets + " " + relativePath;
            } else if (relativePath.endsWith("org-landing-page.html")) {

                assetMappings.orgLandingPage = readContent;
            } else if (relativePath.endsWith("api-landing-page.html")) {

                assetMappings.apiLandingPage = readContent;
            } else if (relativePath.endsWith("orgContent.json")) {
                
                assetMappings.orgLandingPageDetails = readContent;
            }

        }
    }
    return assetMappings;

}

public function readAPIContent(file:MetaData[] directories, string orgname, string apiName, models:APIAssets apiAssets) returns models:APIAssets|error {

    foreach var item in directories {
        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check readAPIContent(meta, orgname, apiName, apiAssets);
        } else {
            string relativePath = check file:relativePath(file:getCurrentDir(), item.absPath);
            if (relativePath.endsWith(".md")) {
                apiAssets.apiContent = check io:fileReadString(relativePath);
            } else if (relativePath.endsWith(".png") || relativePath.endsWith(".jpg") || relativePath.endsWith(".jpeg") ||
            relativePath.endsWith(".gif") || relativePath.endsWith(".svg") || relativePath.endsWith(".ico") || relativePath.endsWith(".webp")) {
                // Should be in a file storage
                apiAssets.apiImages.push(relativePath);
            }
        }
    }

    
    return apiAssets;
}

