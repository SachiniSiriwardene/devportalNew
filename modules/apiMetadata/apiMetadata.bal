public type ApiInfo record {
    string apiCategory;
    string apiDocumentation;
    string ?apiImage;
};

public type ThrottlingPolicy record {
    string policyId;
    string 'type;
    string policyName;
    string description;
};

public type RateLimitingPolicy record {
    string policyName;
    string policyInfo;
};

public type ServerUrl record {
    string sandboxUrl;
    string productionUrl;
};
public type Feedback record {
    string email;
    string rating;
    string comment;
};

public type ApiMetadata record {|
    readonly string apiId;         
    string openApiDefinition;
    ApiInfo apiInfo;
    ThrottlingPolicy[] ?throttlingPolicies;
    string accessibilityRole;
    ServerUrl serverUrl;
    Feedback[] ?feedback;
    string category;
|};
