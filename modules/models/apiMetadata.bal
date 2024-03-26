public type ApiArtifactsResponse record {
    string[] apiContent;
    map<string> apiImages;
};
public type ApiArtifacts record {
    map<string> apiImages;
};
public type ApiInfo record {
    string orgName;
    string apiName;
    string[] apiCategory;
    json openApiDefinition;
    map<string> additionalProperties;
    ApiArtifacts apiArtifacts;
};

public type ApiInfoResponse record {
    string orgName;
    string apiName;
    string[] apiCategory;
    string apiVersion;
    json openApiDefinition;
    APIReview[] reviews?;
    map<string> additionalProperties;
    ApiArtifactsResponse apiArtifacts;
};

public type APIReview record {|
    readonly string reviewId;
    string apiComment;
    int apiRating;
    string apiReviewer;
    string apiID;
    string apiName;
|};

# Description.
#
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
public type ApiMetadata record {
    ApiInfo apiInfo;
    ThrottlingPolicy[]? throttlingPolicies;
    ServerUrl serverUrl;
};

public type ApiMetadataResponse record {
    ApiInfoResponse apiInfo;
    ThrottlingPolicy[]? throttlingPolicies;
    ServerUrl serverUrl;
};


