// import devportal.entry;
// import devportal.models;

// import ballerina/http;

// service /devportal on new http:Listener(9090) {

//     resource function post api(@http:Payload models:ApiMetadata metadata) returns models:ApiMetadata|error {
//         entry:apiMetadataTable.add(metadata);
//         table<models:ApiMetadata> metadataRecords = from var metadataRecord in entry:apiMetadataTable
//             where metadataRecord.apiId == metadata.apiId
//             select metadataRecord;

//         if (metadataRecords.length() > 0) {
//             return metadataRecords.toArray().first()[0];
//         }
//         return error("Error occurred while adding the API metadata");
//     }
//     resource function get api(string apiId) returns models:ApiMetadata|error {
//         table<models:ApiMetadata> metadataRecords = from var metadataRecord in entry:apiMetadataTable
//             where metadataRecord.apiId == apiId
//             select metadataRecord;
//         if (metadataRecords.length() > 0) {
//             return metadataRecords.toArray().first()[0];
//         }
//         return error("Error occurred while retrieving the API metadata");
//     }
// }
