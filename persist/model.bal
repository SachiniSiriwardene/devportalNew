import ballerina/persist as _;


import ballerina/persist as _;

# Description.
#
# + policyId - field description  
# + 'type - field description  
# + policyName - field description  
# + description - field description
public type ThrottlingPolicy record {|
    readonly string policyId;
    string 'type;
    string policyName;
    string description;
	ApiMetadata apimetadata;
|};

# Description.
# + policyId - field description 
# + policyName - field description  
# + policyInfo - field description
public type RateLimitingPolicy record {|
    readonly string policyId;
    string policyName;
    string policyInfo;
|};

# Description.
#
# + apiId - field description  
# + averageRating - field description  
# + noOfRating - field description  
# + noOfComments - field description  
# + reviews - field description
public type Feedback record {|
    readonly string apiId;
    int noOfRating;
    int noOfComments;
    Review[] reviews;
	ApiMetadata apimetadata;
|};

# Description.
#
# + reviewId - field description  
# + reviewedBy - field description  
# + rating - field description  
# + comment - field description
public type Review record {|
    readonly string reviewId;
    string reviewedBy;
    int rating;
    string comment;
	Feedback feedback;
|};

# Description.
#
# + apiId - api id 
# + orgId - organization id
# + apiInfo - api information  
# + throttlingPolicies - details about the throttling policies  
# + serverUrl - Gateway server urls  
# + feedback - feedback provided by each customer 
# + keyManagerUrl - URLs exposed by the key manager
# + apiDetailPageContentUrl - The url of the api detail page content
public type ApiMetadata record {|
    readonly string apiId;
    string orgId;
    string apiName;
    string[] apiCategory;
    string? apiImage;
    string openApiDefinition;
    AdditionalProperties[] additionalProperties;
    ThrottlingPolicy[] throttlingPolicies;
    string productionUrl;
    string sandboxUrl;
    Feedback? feedback;
|};

public type AdditionalProperties record {| 
    readonly string propertyId;
    string key; 
    string value;
	ApiMetadata apimetadata;
|};

# Identity Provider configured for dev portal.
#
# + idpID - field description  
# + name - field description  
# + wellKnownEndpoint - field description  
# + introspectionEndpoint - field description  
# + issuer - field description  
# + jwksEndpoint - field description  
# + authorizeEndpoint - field description  
# + envrionments - field description
public type IdentityProvider record {|
    readonly string idpID;
    string name;
    string wellKnownEndpoint;
    string introspectionEndpoint;
    string issuer;
    string jwksEndpoint;
    string authorizeEndpoint;
    string[] envrionments;
|};

public type Theme record {|
    readonly string themeId;   
    string orgId;    
    string theme;
|};

# Represents content to be included in the application section.
#
# + appId - application id  
# + applicationName - application name  
# + sandBoxKey - field description  
# + productionKey - field description  
# + appProperties - list of properties as application information  
# + addedAPIs - list of added APIs for the application  
# + accessControl - access control for the application  
# + idpId - field description
public type Application record {|
    readonly string appId;
    string applicationName;
    string sandBoxKey;
    string productionKey;
    ApplicationProperties[] appProperties;
    string[] addedAPIs;
    User[] accessControl;
    string idpId;
|};

public type Organization record {|
    readonly string orgId;
    string[] subscribedAPIs;
|};

public type ApplicationProperties record {|
    readonly string propertyId;
    string name;
    string value;
    Application application;
|};

public type User record {|
    readonly string userId;
    string role;
    string userName;
    Application application;
|};

public type Subscription record {|
    readonly string subscriptionId;
    string apiId;
    string orgId;
    string userId;
|};

public type ConsumerReview record {|
    readonly string reviewId;
    string apiId;
    string comment;
    int rating;
    string userId;
|};