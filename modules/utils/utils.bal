import devportal.models;

import ballerina/file;
import ballerina/log;
import ballerina/mime;
import ballerina/regex;

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

            //string relativePath = check file:relativePath(orgName, item.absPath);
            string[] names = regex:split(item.absPath, orgName);
            string relativePath = names[1];
            if (relativePath.endsWith(".md")) {
                assetMappings.orgAssets.push(relativePath);
            } else if (relativePath.endsWith(".css")) {
                assetMappings.orgAssets.push(relativePath);

            } else if (relativePath.endsWith(".mp4") || relativePath.endsWith(".webm") || relativePath.endsWith(".ogv")) {
                assetMappings.orgAssets.push(relativePath);

            } else if (relativePath.endsWith(".png") || relativePath.endsWith(".jpg") || relativePath.endsWith(".jpeg") ||
            relativePath.endsWith(".gif") || relativePath.endsWith(".svg") || relativePath.endsWith(".ico") || relativePath.endsWith(".webp")) {
                assetMappings.orgAssets.push(relativePath);
            } else if (relativePath.endsWith("org-landing-page.html")) {
                assetMappings.landingPageUrl = relativePath;
            }

        }
    }
    return assetMappings;

}

function readAPIContent(file:MetaData[] directories, string path, models:APIAssets assetMappings) returns models:APIAssets|error {

    foreach var item in directories {
        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check readAPIContent(meta, path, assetMappings);
        } else {
            string relativePath = check file:relativePath(file:getCurrentDir(), item.absPath);
            if (relativePath.endsWith(".html")) {
                if (relativePath.endsWith("api-landing-page.html")) {
                    assetMappings.landingPageUrl = relativePath;
                }
                assetMappings.apiAssets.push(relativePath);
            } else if (relativePath.endsWith(".md")) {
                assetMappings.apiAssets.push(relativePath);
            } else if (relativePath.endsWith(".png") || relativePath.endsWith(".jpg") || relativePath.endsWith(".jpeg") ||
            relativePath.endsWith(".gif") || relativePath.endsWith(".svg") || relativePath.endsWith(".ico") || relativePath.endsWith(".webp")) {
                assetMappings.apiAssets.push(relativePath);
            }
        }
    }
    return assetMappings;
}

public function getContentForAPITemplate(file:MetaData[] directories, string path, models:APIAssets assetMappings) returns models:APIAssets|error {

    foreach var item in directories {
        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check getContentForAPITemplate(meta, path, assetMappings);
        } else {
            string[] names = regex:split(item.absPath, path);
            string relativePath = names[1];
            if (relativePath.endsWith(".md")) {
                assetMappings.apiAssets.push(relativePath);
            } else if (relativePath.endsWith(".css")) {
                assetMappings.apiAssets.push(relativePath);

            } else if (relativePath.endsWith(".mp4") || relativePath.endsWith(".webm") || relativePath.endsWith(".ogv")) {
                assetMappings.apiAssets.push(relativePath);

            } else if (relativePath.endsWith(".png") || relativePath.endsWith(".jpg") || relativePath.endsWith(".jpeg") ||
            relativePath.endsWith(".gif") || relativePath.endsWith(".svg") || relativePath.endsWith(".ico") || relativePath.endsWith(".webp")) {
                assetMappings.apiAssets.push(relativePath);
            }
        }
    }
    return assetMappings;
}
