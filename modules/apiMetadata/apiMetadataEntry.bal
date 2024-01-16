public distinct service class ApiMetadataEntry {
    private final readonly & ApiMetadata entryRecord;

    // public function init(ApiMetadata entryRecord) {
    //     self.entryRecord = entryRecord.cloneReadOnly();
    // }

    // resource function get apiId() returns string {
    //     return self.entryRecord.apiId;
    // }
    // resource function get openApiDefinition() returns json|error {
    //     io:println(self.entryRecord.openApiDefinition);
    //     return self.entryRecord.openApiDefinition;
    // }
    // resource function get apiInfo() returns ApiInformation {
    //     return new ApiInformation(self.entryRecord.apiInfo);
    // }

    // resource function get accessibilityRole() returns string {
    //     return self.entryRecord.accessibilityRole;
    // }

}