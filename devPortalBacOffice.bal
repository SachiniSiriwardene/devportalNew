import ballerina/http;
import devportal.apiMetadata;
import devportal.content;

service /devportal on new http:Listener(9090) {

    // This function responds with `string` value `Hello, World!` to HTTP GET requests.
    resource function post apiMetadata(@http:Payload apiMetadata:ApiMetadataEntry metadata) returns json{
        content:apiMetadataEntriesTable.add(metadata);
        table<apiMetadata:ApiMetadataEntry> metadataRecords = from var metadataRecord in content:apiMetadataEntriesTable
                            where metadataRecord.apiId == metadata.apiId
                            select metadataRecord;
        return metadataRecords.toJson();
    }
    resource function get apiMetadata(string apiId) returns json {
        table<apiMetadata:ApiMetadataEntry> metadataRecords = from var metadataRecord in content:apiMetadataEntriesTable
                            where metadataRecord.apiId == apiId
                            select metadataRecord;
        return metadataRecords.toJson();
    }
}
