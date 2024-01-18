public type ApiInfo record {
    string apiName;
    string apiCategory;
    string apiDocumentation;
    string ?apiImage;
    string lifeCycleStatus;         
    json openApiDefinition;
    map<string> additionalProperties;
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
    string apiId;
    string averageRating;
    int noOfRating;
    int noOfComments;
    Review[] reviews;
};
public type Review record {
    string reviewId;
    string reviewedBy;
    int rating;
    string comment;
};
public type Keymanager record {
    string name;
    string tokenEndpointUrl;
    string revokeEndpointUrl;
    string authorizeEndpointUrl;
};

public type ApiMetadata record {|
    readonly string apiId;
    ApiInfo apiInfo;
    ThrottlingPolicy[] ?throttlingPolicies;
    ServerUrl serverUrl;
    Feedback ?feedback;
    Keymanager keyManagerUrl;
|};
