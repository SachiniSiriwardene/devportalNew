public type ApiInfoEntry record {
    string apiCategory;
    string apiDocumentation;
    string ?apiImage;
};

public type UsagePolicyEntry record {
    string policyName;
    string policyInfo;
};

public type RateLimitingPolicyEntry record {
    string policyName;
    string policyInfo;
};

public type ServerUrlEntry record {
    string sandboxUrl;
    string productionUrl;
};

public type ApiMetadataEntry record {|
    readonly string apiId;         
    json openApiDefinition;
    ApiInfoEntry apiInfo;
    UsagePolicyEntry usagePolicy;
    RateLimitingPolicyEntry ?rateLimitingPolicy;
    string accessibilityRole;
    ServerUrlEntry serverUrl;
|};
