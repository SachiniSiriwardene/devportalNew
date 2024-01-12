import ballerina/io;
public distinct service class ApiMetadata {
    private final readonly & ApiMetadataEntry entryRecord;

    public function init(ApiMetadataEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get apiId() returns string {
        return self.entryRecord.apiId;
    }
    resource function get openApiDefinition() returns string|error {
        io:println(self.entryRecord.openApiDefinition);
        return self.entryRecord.openApiDefinition;
    }
    resource function get apiInfo() returns ApiInformation {
        return new ApiInformation(self.entryRecord.apiInfo);
    }
    resource function get usagePolicy() returns UsagePolicy {
        return new UsagePolicy(self.entryRecord.usagePolicy);
    }
    resource function get rateLimitingPolicy() returns RateLimitingPolicy {
        return new RateLimitingPolicy(self.entryRecord.rateLimitingPolicy);
    }
    resource function get accessibilityRole() returns string {
        return self.entryRecord.accessibilityRole;
    }
    resource function get serverUrl() returns ServerUrl {
        return new ServerUrl(self.entryRecord.serverUrl);
    }

}