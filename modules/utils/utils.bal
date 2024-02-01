import ballerina/log;
import ballerina/mime;

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
