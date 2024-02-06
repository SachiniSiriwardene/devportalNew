// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type ThrottlingPolicy record {|
    readonly string policyId;
    string 'type;
    string policyName;
    string description;
    string apimetadataApiId;
|};

public type ThrottlingPolicyOptionalized record {|
    string policyId?;
    string 'type?;
    string policyName?;
    string description?;
    string apimetadataApiId?;
|};

public type ThrottlingPolicyWithRelations record {|
    *ThrottlingPolicyOptionalized;
    ApiMetadataOptionalized apimetadata?;
|};

public type ThrottlingPolicyTargetType typedesc<ThrottlingPolicyWithRelations>;

public type ThrottlingPolicyInsert ThrottlingPolicy;

public type ThrottlingPolicyUpdate record {|
    string 'type?;
    string policyName?;
    string description?;
    string apimetadataApiId?;
|};

public type RateLimitingPolicy record {|
    readonly string policyId;
    string policyName;
    string policyInfo;
|};

public type RateLimitingPolicyOptionalized record {|
    string policyId?;
    string policyName?;
    string policyInfo?;
|};

public type RateLimitingPolicyTargetType typedesc<RateLimitingPolicyOptionalized>;

public type RateLimitingPolicyInsert RateLimitingPolicy;

public type RateLimitingPolicyUpdate record {|
    string policyName?;
    string policyInfo?;
|};

public type Feedback record {|
    readonly string apiId;
    int noOfRating;
    int noOfComments;
    string apimetadataApiId;
|};

public type FeedbackOptionalized record {|
    string apiId?;
    int noOfRating?;
    int noOfComments?;
    string apimetadataApiId?;
|};

public type FeedbackWithRelations record {|
    *FeedbackOptionalized;
    ReviewOptionalized[] reviews?;
    ApiMetadataOptionalized apimetadata?;
|};

public type FeedbackTargetType typedesc<FeedbackWithRelations>;

public type FeedbackInsert Feedback;

public type FeedbackUpdate record {|
    int noOfRating?;
    int noOfComments?;
    string apimetadataApiId?;
|};

public type Review record {|
    readonly string reviewId;
    string reviewedBy;
    int rating;
    string comment;
    string feedbackApiId;
|};

public type ReviewOptionalized record {|
    string reviewId?;
    string reviewedBy?;
    int rating?;
    string comment?;
    string feedbackApiId?;
|};

public type ReviewWithRelations record {|
    *ReviewOptionalized;
    FeedbackOptionalized feedback?;
|};

public type ReviewTargetType typedesc<ReviewWithRelations>;

public type ReviewInsert Review;

public type ReviewUpdate record {|
    string reviewedBy?;
    int rating?;
    string comment?;
    string feedbackApiId?;
|};

public type ApiMetadata record {|
    readonly string apiId;
    string orgId;
    string apiName;
    string[] apiCategory;
    string? apiImage;
    string openApiDefinition;
    string productionUrl;
    string sandboxUrl;
|};

public type ApiMetadataOptionalized record {|
    string apiId?;
    string orgId?;
    string apiName?;
    string[] apiCategory?;
    string? apiImage?;
    string openApiDefinition?;
    string productionUrl?;
    string sandboxUrl?;
|};

public type ApiMetadataWithRelations record {|
    *ApiMetadataOptionalized;
    AdditionalPropertiesOptionalized[] additionalProperties?;
    ThrottlingPolicyOptionalized[] throttlingPolicies?;
    FeedbackOptionalized feedback?;
|};

public type ApiMetadataTargetType typedesc<ApiMetadataWithRelations>;

public type ApiMetadataInsert ApiMetadata;

public type ApiMetadataUpdate record {|
    string orgId?;
    string apiName?;
    string[] apiCategory?;
    string? apiImage?;
    string openApiDefinition?;
    string productionUrl?;
    string sandboxUrl?;
|};

public type AdditionalProperties record {|
    readonly string propertyId;
    string key;
    string value;
    string apimetadataApiId;
|};

public type AdditionalPropertiesOptionalized record {|
    string propertyId?;
    string key?;
    string value?;
    string apimetadataApiId?;
|};

public type AdditionalPropertiesWithRelations record {|
    *AdditionalPropertiesOptionalized;
    ApiMetadataOptionalized apimetadata?;
|};

public type AdditionalPropertiesTargetType typedesc<AdditionalPropertiesWithRelations>;

public type AdditionalPropertiesInsert AdditionalProperties;

public type AdditionalPropertiesUpdate record {|
    string key?;
    string value?;
    string apimetadataApiId?;
|};

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

public type IdentityProviderOptionalized record {|
    string idpID?;
    string name?;
    string wellKnownEndpoint?;
    string introspectionEndpoint?;
    string issuer?;
    string jwksEndpoint?;
    string authorizeEndpoint?;
    string[] envrionments?;
|};

public type IdentityProviderTargetType typedesc<IdentityProviderOptionalized>;

public type IdentityProviderInsert IdentityProvider;

public type IdentityProviderUpdate record {|
    string name?;
    string wellKnownEndpoint?;
    string introspectionEndpoint?;
    string issuer?;
    string jwksEndpoint?;
    string authorizeEndpoint?;
    string[] envrionments?;
|};

public type Theme record {|
    readonly string themeId;
    string orgId;
    string theme;
|};

public type ThemeOptionalized record {|
    string themeId?;
    string orgId?;
    string theme?;
|};

public type ThemeTargetType typedesc<ThemeOptionalized>;

public type ThemeInsert Theme;

public type ThemeUpdate record {|
    string orgId?;
    string theme?;
|};

public type Application record {|
    readonly string appId;
    string applicationName;
    string sandBoxKey;
    string productionKey;
    string[] addedAPIs;
    string idpId;
|};

public type ApplicationOptionalized record {|
    string appId?;
    string applicationName?;
    string sandBoxKey?;
    string productionKey?;
    string[] addedAPIs?;
    string idpId?;
|};

public type ApplicationWithRelations record {|
    *ApplicationOptionalized;
    ApplicationPropertiesOptionalized[] appProperties?;
    UserOptionalized[] accessControl?;
|};

public type ApplicationTargetType typedesc<ApplicationWithRelations>;

public type ApplicationInsert Application;

public type ApplicationUpdate record {|
    string applicationName?;
    string sandBoxKey?;
    string productionKey?;
    string[] addedAPIs?;
    string idpId?;
|};

public type Organization record {|
    readonly string orgId;
    string[] subscribedAPIs;
|};

public type OrganizationOptionalized record {|
    string orgId?;
    string[] subscribedAPIs?;
|};

public type OrganizationTargetType typedesc<OrganizationOptionalized>;

public type OrganizationInsert Organization;

public type OrganizationUpdate record {|
    string[] subscribedAPIs?;
|};

public type ApplicationProperties record {|
    readonly string propertyId;
    string name;
    string value;
    string applicationAppId;
|};

public type ApplicationPropertiesOptionalized record {|
    string propertyId?;
    string name?;
    string value?;
    string applicationAppId?;
|};

public type ApplicationPropertiesWithRelations record {|
    *ApplicationPropertiesOptionalized;
    ApplicationOptionalized application?;
|};

public type ApplicationPropertiesTargetType typedesc<ApplicationPropertiesWithRelations>;

public type ApplicationPropertiesInsert ApplicationProperties;

public type ApplicationPropertiesUpdate record {|
    string name?;
    string value?;
    string applicationAppId?;
|};

public type User record {|
    readonly string userId;
    string role;
    string userName;
    string applicationAppId;
|};

public type UserOptionalized record {|
    string userId?;
    string role?;
    string userName?;
    string applicationAppId?;
|};

public type UserWithRelations record {|
    *UserOptionalized;
    ApplicationOptionalized application?;
|};

public type UserTargetType typedesc<UserWithRelations>;

public type UserInsert User;

public type UserUpdate record {|
    string role?;
    string userName?;
    string applicationAppId?;
|};

public type Subscription record {|
    readonly string subscriptionId;
    string apiId;
    string orgId;
    string userId;
|};

public type SubscriptionOptionalized record {|
    string subscriptionId?;
    string apiId?;
    string orgId?;
    string userId?;
|};

public type SubscriptionTargetType typedesc<SubscriptionOptionalized>;

public type SubscriptionInsert Subscription;

public type SubscriptionUpdate record {|
    string apiId?;
    string orgId?;
    string userId?;
|};

public type ConsumerReview record {|
    readonly string reviewId;
    string apiId;
    string comment;
    int rating;
    string userId;
|};

public type ConsumerReviewOptionalized record {|
    string reviewId?;
    string apiId?;
    string comment?;
    int rating?;
    string userId?;
|};

public type ConsumerReviewTargetType typedesc<ConsumerReviewOptionalized>;

public type ConsumerReviewInsert ConsumerReview;

public type ConsumerReviewUpdate record {|
    string apiId?;
    string comment?;
    int rating?;
    string userId?;
|};

