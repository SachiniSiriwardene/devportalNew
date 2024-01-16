// import devportal.apiMetadata;
// import devportal.content;
// import ballerina/graphql;
// import ballerina/io;

// service /devPortalBackOffice on new graphql:Listener(5000) {

//      remote function fileUpload(graphql:Upload file) returns string {
//         string fileName = file.fileName;
//         string mimeType = file.mimeType;
//         string encoding = file.encoding;
//         stream<byte[], io:Error?> byteStream = file.byteStream;
//         return fileName;
//      }

//     remote function addMetadata(apiMetadata:ApiMetadataEntry metadata) returns apiMetadata:ApiMetadata|error {
//         io:println(metadata.openApiDefinition);
//         content:apiMetadataEntriesTable.add(metadata);
//         return new apiMetadata:ApiMetadata(metadata);
//     }

//     resource function get allAPIMetadata() returns apiMetadata:ApiMetadata[] {
//         apiMetadata:ApiMetadataEntry[] apiMetadataEntries = content:apiMetadataEntriesTable.toArray().cloneReadOnly();
//         return apiMetadataEntries.map(entry => new apiMetadata:ApiMetadata(entry));
//     }

//     resource function get apiMetadata(string id) returns apiMetadata:ApiMetadata? {
//         apiMetadata:ApiMetadataEntry? apiMetadataEntry = content:apiMetadataEntriesTable[id];
//         if apiMetadataEntry is apiMetadata:ApiMetadataEntry {
//             return new (apiMetadataEntry);
//         }
//         return;
//     }

// }

