import ballerina/http;
import devportal.apiMetadata;
import devportal.content;

service /devportal on new http:Listener(9090) {

    resource function post api(@http:Payload apiMetadata:ApiMetadata metadata) returns json{
        content:apiMetadataEntriesTable.add(metadata);
        table<apiMetadata:ApiMetadata> metadataRecords = from var metadataRecord in content:apiMetadataEntriesTable
                            where metadataRecord.apiId == metadata.apiId
                            select metadataRecord;
        return metadataRecords.toJson();
    }
    resource function get api(string apiId) returns json {
        table<apiMetadata:ApiMetadata> metadataRecords = from var metadataRecord in content:apiMetadataEntriesTable
                            where metadataRecord.apiId == apiId
                            select metadataRecord;
        return metadataRecords.toJson();
    }
}
