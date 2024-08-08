import devportal.models;

import ballerina/file;
import ballerina/io;
import ballerina/log;
import ballerina/mime;
import ballerinax/aws.s3;

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

public function pushContentS3(file:MetaData[] directories, string contentType) returns error? {

    log:printDebug("Reading API Content");
    foreach var item in directories {
        s3:Client|error amazonS3Client = createAmazonS3Client();
        string relativePath = check file:relativePath(file:getCurrentDir(), item.absPath);

        byte[] imgContent = check io:fileReadBytes(relativePath);
        int lastIndex = <int>relativePath.lastIndexOf("/");

        if (amazonS3Client is s3:Client) {
            io:println("Uploading Content to Amazon S3: " + relativePath);
            s3:ObjectCreationHeaders objectCreationHeaders = {};
            objectCreationHeaders.contentType = contentType;
            var result = amazonS3Client->createObject("devportal-content/" + relativePath.substring(0, lastIndex), relativePath.substring(lastIndex + 1), imgContent, s3:ACL_PUBLIC_READ, objectCreationHeaders);
            if (result is error) {
                log:printError("Error uploading the org landing page to Amazon S3");
            }
        }
    }
}

public function readAPIContent(file:MetaData[] directories, string orgname, string apiID, models:APIAssets[] apiAssets) returns models:APIAssets[]|error {

    log:printDebug("Reading API Content");
    foreach var item in directories {
        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check readAPIContent(meta, orgname, apiID, apiAssets);
        } else {
            string relativePath = check file:relativePath(file:getCurrentDir(), item.absPath);
            string fileName = item.absPath.substring(<int>(item.absPath.lastIndexOf("/") + 1), item.absPath.length());
            if (relativePath.endsWith("md") || relativePath.endsWith("hbs")) {
                models:APIAssets assetMapping = {
                    apiContent: check io:fileReadString(relativePath),
                    fileName: fileName,
                    apiImages: [],
                    apiId: apiID
                };
                apiAssets.push(assetMapping);
            }
        }
    }
    return apiAssets;
}

public function createAmazonS3Client() returns s3:Client|error {
    s3:ConnectionConfig amazonS3Config = {
        accessKeyId: models:awsAccessKeyId,
        secretAccessKey: models:awsSecretAccessKey,
        region: models:awsRegion,
        timeout: 120
    };

    return check new (amazonS3Config);
}

public function getAssetmapping(file:MetaData[] directory, models:OrganizationAssets[] assetMappings, string pageType, string orgId, string orgName)
returns models:OrganizationAssets[]|error {

    foreach var item in directory {

        if (item.dir) {
            file:MetaData[] meta = check file:readDir(item.absPath);
            _ = check getAssetmapping(meta, assetMappings, pageType, orgId, orgName);
        } else {
            string fileName = item.absPath.substring(<int>(item.absPath.lastIndexOf("/") + 1), item.absPath.length());
            string filePath = "";
            if (item.absPath.includesMatch(re `/views`) && !fileName.endsWith(".DS_Store")) {
                filePath = item.absPath.substring(<int>(item.absPath.indexOf("/views") + 6), item.absPath.indexOf(".hbs") ?: 0);
            }

            log:printInfo(filePath);

            if (!fileName.equalsIgnoreCaseAscii(".DS_Store")) {
                string pageContent = check io:fileReadString(item.absPath);
                models:OrganizationAssets assetMapping = {
                    pageType: pageType,
                    pageContent: pageContent,
                    orgId: orgId,
                    orgName: orgName,
                    pageName: fileName,
                    fileName: filePath
                };
                assetMappings.push(assetMapping);
            }
        }
    }
    return assetMappings;
}
