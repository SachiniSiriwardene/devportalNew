import devportal.apiMetadata;
import ballerina/graphql;
import ballerina/io;
import devportal.theme;

service /devportal on new graphql:Listener(4000) {

     remote function fileUpload(graphql:Upload file) returns string {
        string fileName = file.fileName;
        string mimeType = file.mimeType;
        string encoding = file.encoding;
        stream<byte[], io:Error?> byteStream = file.byteStream;
        return fileName;
     }

    remote function addMetadata(apiMetadata:ApiMetadataEntry metadata) returns apiMetadata:ApiMetadata|error {
        io:println(metadata.openApiDefinition);
        apiMetadataEntriesTable.add(metadata);
        return new apiMetadata:ApiMetadata(metadata);
    }

    resource function get allAPIMetadata() returns apiMetadata:ApiMetadata[] {
        apiMetadata:ApiMetadataEntry[] apiMetadataEntries = apiMetadataEntriesTable.toArray().cloneReadOnly();
        return apiMetadataEntries.map(entry => new apiMetadata:ApiMetadata(entry));
    }

    resource function get apiMetadata(string id) returns apiMetadata:ApiMetadata? {
        apiMetadata:ApiMetadataEntry? apiMetadataEntry = apiMetadataEntriesTable[id];
        if apiMetadataEntry is apiMetadata:ApiMetadataEntry {
            return new (apiMetadataEntry);
        }
        return;
    }

    remote function addTheme(theme:ThemeEntry theme) returns theme:Theme|error {
        themeEntriesTable.add(theme);
        return new theme:Theme(theme);
    }

    resource function get allThemes() returns theme:Theme[] {
        theme:ThemeEntry[] themeEntries = themeEntriesTable.toArray().cloneReadOnly();
        return themeEntries.map(entry => new theme:Theme(entry));
    }

    resource function get theme(string id) returns theme:Theme? {
        theme:ThemeEntry? themeEntriy = themeEntriesTable[id];
        if themeEntriy is theme:ThemeEntry {
            return new (themeEntriy);
        }
        return;
    }
}

