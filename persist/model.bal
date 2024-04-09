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
    Subscription? subscription;
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
# + reviewId - field description  
# + rating - field description  
# + comment - field description  
# + apiFeedback - field description  
# + reviewedBy - field description
public type Review record {|
    readonly string reviewId;
    int rating;
    string comment;
    ApiMetadata apiFeedback;
    User reviewedBy;
|};

# Description.
#
# + apiId - api id  
# + orgId - organization id  
# + apiName - field description  
# + organizationName - field description  
# + apiCategory - field description  
# + openApiDefinition - field description  
# + additionalProperties - field description  
# + throttlingPolicies - details about the throttling policies  
# + productionUrl - field description  
# + sandboxUrl - field description  
# + reviews - field description  
# + subscriptions - field description  
# + apiContent - field description  
# + apiImages - field description  
# + authorizedRoles - field description
public type ApiMetadata record {|
    readonly string apiId;
    string orgId;
    string apiName;
    readonly string organizationName;
    string apiCategory;
    string openApiDefinition;
    AdditionalProperties[] additionalProperties;
    ThrottlingPolicy[] throttlingPolicies;
    string productionUrl;
    string sandboxUrl;
    Review[] reviews;
    Subscription[] subscriptions;
    ApiContent[] apiContent;
    ApiImages[] apiImages;
    string? authorizedRoles;
|};


public type ApiContent record {|
    readonly string contentId;
    string apiContent;
	ApiMetadata apimetadata;
|};

public type ApiImages record {|
    readonly string imageId;
    string key;
    string value;
	ApiMetadata apimetadata;
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
# + organization - field description
public type IdentityProvider record {|
    readonly string idpID;
    string name;
    string wellKnownEndpoint;
    string introspectionEndpoint;
    string issuer;
    string jwksEndpoint;
    string authorizeEndpoint;
    string envrionments;
    Organization organization;
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
    string addedAPIs;
    User[] accessControl;
    string idpId;
|};

public type Organization record {|
    readonly string orgId;
    string organizationName;
    string templateName;
    boolean isPublic; 
    string authenticatedPages;
    OrganizationAssets? organizationAssets;
    IdentityProvider[] identityProvider;
    Subscription[] subscriptions;
|};


# Assets needed for the org landing page.
#
# + assetId - field description  
# + orgAssets - field description  
# + orgLandingPage - field description  
# + apiLandingPage - field description  
# + apiListingPage - field description  
# + navigationBar - field description  
# + footerPage - field description  
# + organization - field description
public type OrganizationAssets record {|
    readonly string assetId;
    string? orgAssets;
    string orgLandingPage;
    string apiLandingPage;
    string apiListingPage;
    string navigationBar;
    string footerPage;
    Organization organization;
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
    Review[] reviews;
    Subscription[] subscriptions;
|};

public type Subscription record {|
    readonly string subscriptionId;
    ApiMetadata api;
    User user;
    Organization organization;
    ThrottlingPolicy subscriptionPolicy;
|};

