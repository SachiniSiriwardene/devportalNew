public type ApiInfo record {
    string apiName;
    string[] apiCategory;
    ContentDescription apiDocumentation;
    string? apiImage;
    string lifeCycleStatus;
    json openApiDefinition;
    map<string> additionalProperties;
};

# Description.
#
# + policyId - field description  
# + 'type - field description  
# + policyName - field description  
# + description - field description
public type ThrottlingPolicy record {
    string policyId;
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
# + apiId - field description  
# + averageRating - field description  
# + noOfRating - field description  
# + noOfComments - field description  
# + reviews - field description
public type Feedback record {
    string apiId;
    int averageRating;
    int noOfRating;
    int noOfComments;
    Review[] reviews;
};

# Description.
#
# + reviewId - field description  
# + reviewedBy - field description  
# + rating - field description  
# + comment - field description
public type Review record {
    string reviewId;
    string reviewedBy;
    int rating;
    string comment;
};

# Description.
#
# + name - field description  
# + tokenEndpointUrl - field description  
# + revokeEndpointUrl - field description  
# + authorizeEndpointUrl - field description
public type KeyManager record {
    string name;
    string tokenEndpointUrl;
    string revokeEndpointUrl;
    string authorizeEndpointUrl;
};

# Description.
#
# + apiId - api id 
# + orgId - organization id
# + apiInfo - api information  
# + throttlingPolicies - details about the throttling policies  
# + serverUrl - Gateway server urls  
# + feedback - feedback provided by each customer 
# + keyManagerUrl - URLs exposed by the key manager
# + apiDetailPageContent - content of the api detail page
public type ApiMetadata record {|
    readonly string apiId;
    string orgId;
    ApiInfo apiInfo;
    ThrottlingPolicy[]? throttlingPolicies;
    ServerUrl serverUrl;
    Feedback? feedback;
    KeyManager keyManagerUrl;
    ComponentContent apiDetailPageContent;
|};

