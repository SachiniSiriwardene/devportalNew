import ballerina/http;
import devportal.apiMetadata;
import devportal.theme;

service /devportal on new http:Listener(9090) {

    // This function responds with `string` value `Hello, World!` to HTTP GET requests.
    resource function post apiMetadata(@http:Payload apiMetadata:ApiMetadataEntry metadata) returns json{
        apiMetadataEntriesTable.add(metadata);
        table<apiMetadata:ApiMetadataEntry> metadataRecords = from var metadataRecord in apiMetadataEntriesTable
                            where metadataRecord.apiId == metadata.apiId
                            select metadataRecord;
        return metadataRecords.toJson();
    }
    resource function get apiMetadata(string apiId) returns json {
        table<apiMetadata:ApiMetadataEntry> metadataRecords = from var metadataRecord in apiMetadataEntriesTable
                            where metadataRecord.apiId == apiId
                            select metadataRecord;
        return metadataRecords.toJson();
    }
    resource function post theme(@http:Payload theme:ThemeEntry themeData) returns json{
        themeEntriesTable.add(themeData);
        table<theme:ThemeEntry> themeRecords = from var themeRecord in themeEntriesTable
                            where themeRecord.themeId == themeData.themeId
                            select themeRecord;
        return themeRecords.toJson();
    }
    resource function get theme(string themeId) returns json{
                table<theme:ThemeEntry> themeRecords = from var themeRecord in themeEntriesTable
                            where themeRecord.themeId == themeId
                            select themeRecord;
        return themeRecords.toJson();
    }
}