public type ApiInfo record {
    string apiName;
    string[] apiCategory;
    string? apiImage;
    string openApiDefinition;
    map<string> additionalProperties;
};

# Description.
#
# + policyId - field description  
# + 'type - field description  
# + policyName - field description  
# + description - field description
public type ThrottlingPolicy record {
    string 'type;
    string policyName;
    string description;
};

# Description.
#
# + policyName - field description  
# + policyInfo - field description
public type RateLimitingPolicy record {
    string policyName;
    string policyInfo;
};

# Description.
#
# + sandboxUrl - field description  
# + productionUrl - field description
public type ServerUrl record {
    string sandboxUrl;
    string productionUrl;
};

# Description.
#
# + apiInfo - api information  
# + throttlingPolicies - details about the throttling policies  
# + serverUrl - Gateway server urls  
# + feedback - feedback provided by each customer 
# + keyManagerUrl - URLs exposed by the key manager
# + apiDetailPageContentUrl - The url of the api detail page content
public type ApiMetadata record {
    ApiInfo apiInfo;
    ThrottlingPolicy[]? throttlingPolicies;
    ServerUrl serverUrl;
};

