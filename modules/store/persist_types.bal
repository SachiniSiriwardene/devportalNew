// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type ThrottlingPolicy record {|
    readonly string policyId;
    string 'type;
    string policyName;
    string description;
    string apimetadataApiId;
    string apimetadataOrganizationName;

|};

public type ThrottlingPolicyOptionalized record {|
    string policyId?;
    string 'type?;
    string policyName?;
    string description?;
    string apimetadataApiId?;
    string apimetadataOrganizationName?;
|};

public type ThrottlingPolicyWithRelations record {|
    *ThrottlingPolicyOptionalized;
    ApiMetadataOptionalized apimetadata?;
    SubscriptionOptionalized subscription?;
|};

public type ThrottlingPolicyTargetType typedesc<ThrottlingPolicyWithRelations>;

public type ThrottlingPolicyInsert ThrottlingPolicy;

public type ThrottlingPolicyUpdate record {|
    string 'type?;
    string policyName?;
    string description?;
    string apimetadataApiId?;
    string apimetadataOrganizationName?;
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

public type Review record {|
    readonly string reviewId;
    int rating;
    string comment;
    string apifeedbackApiId;
    string apifeedbackOrganizationName;
    string reviewedbyUserId;
|};

public type ReviewOptionalized record {|
    string reviewId?;
    int rating?;
    string comment?;
    string apifeedbackApiId?;
    string apifeedbackOrganizationName?;
    string reviewedbyUserId?;
|};

public type ReviewWithRelations record {|
    *ReviewOptionalized;
    ApiMetadataOptionalized apiFeedback?;
    UserOptionalized reviewedBy?;
|};

public type ReviewTargetType typedesc<ReviewWithRelations>;

public type ReviewInsert Review;

public type ReviewUpdate record {|
    int rating?;
    string comment?;
    string apifeedbackApiId?;
    string apifeedbackOrganizationName?;
    string reviewedbyUserId?;
|};

public type ApiMetadata record {|
    readonly string apiId;
    string orgId;
    string apiName;
    string metadata;
    readonly string organizationName;
    string apiCategory;
    string openApiDefinition;

    string productionUrl;
    string sandboxUrl;

    string? authorizedRoles;
|};

public type ApiMetadataOptionalized record {|
    string apiId?;
    string orgId?;
    string apiName?;
    string metadata?;
    string organizationName?;
    string apiCategory?;
    string openApiDefinition?;
    string productionUrl?;
    string sandboxUrl?;
    string? authorizedRoles?;
|};

public type ApiMetadataWithRelations record {|
    *ApiMetadataOptionalized;
    AdditionalPropertiesOptionalized[] additionalProperties?;
    ThrottlingPolicyOptionalized[] throttlingPolicies?;
    ReviewOptionalized[] reviews?;
    SubscriptionOptionalized[] subscriptions?;
    ApiContentOptionalized[] apiContent?;
    ApiImagesOptionalized[] apiImages?;
|};

public type ApiMetadataTargetType typedesc<ApiMetadataWithRelations>;

public type ApiMetadataInsert ApiMetadata;

public type ApiMetadataUpdate record {|
    string orgId?;
    string apiName?;
    string metadata?;
    string apiCategory?;
    string openApiDefinition?;
    string productionUrl?;
    string sandboxUrl?;
    string? authorizedRoles?;
|};

public type ApiContent record {|
    readonly string contentId;
    string apiContent;
    string apimetadataApiId;
    string apimetadataOrganizationName;
|};

public type ApiContentOptionalized record {|
    string contentId?;
    string apiContent?;
    string apimetadataApiId?;
    string apimetadataOrganizationName?;
|};

public type ApiContentWithRelations record {|
    *ApiContentOptionalized;
    ApiMetadataOptionalized apimetadata?;
|};

public type ApiContentTargetType typedesc<ApiContentWithRelations>;

public type ApiContentInsert ApiContent;

public type ApiContentUpdate record {|
    string apiContent?;
    string apimetadataApiId?;
    string apimetadataOrganizationName?;
|};

public type ApiImages record {|
    readonly string imageId;
    string key;
    string value;
    byte[] image?;
    string apimetadataApiId;
    string apimetadataOrganizationName;
|};

public type ApiImagesOptionalized record {|
    string imageId?;
    string key?;
    string value?;
    string apimetadataApiId?;
    byte[] image?;
    string apimetadataOrganizationName?;
|};

public type ApiImagesWithRelations record {|
    *ApiImagesOptionalized;
    ApiMetadataOptionalized apimetadata?;
|};

public type ApiImagesTargetType typedesc<ApiImagesWithRelations>;

public type ApiImagesInsert ApiImages;

public type ApiImagesUpdate record {|
    string key?;
    string value?;
    string apimetadataApiId?;
    byte[] image?;
    string apimetadataOrganizationName?;
|};

public type OrgImages record {|
    readonly string imageId;
    string fileName;
    byte[] image;
    string organizationOrgId;
|};

public type OrgImagesOptionalized record {|
    string imageId?;
    string fileName?;
    byte[] image?;
    string organizationOrgId?;
|};

public type OrgImagesWithRelations record {|
    *OrgImagesOptionalized;
    OrganizationOptionalized organization?;
|};

public type OrgImagesTargetType typedesc<OrgImagesWithRelations>;

public type OrgImagesInsert OrgImages;

public type OrgImagesUpdate record {|
    string fileName?;
    byte[] image?;
    string organizationOrgId?;
|};

public type AdditionalProperties record {|
    readonly string propertyId;
    string key;
    string value;
    string apimetadataApiId;
    string apimetadataOrganizationName;
|};

public type AdditionalPropertiesOptionalized record {|
    string propertyId?;
    string key?;
    string value?;
    string apimetadataApiId?;
    string apimetadataOrganizationName?;
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
    string apimetadataOrganizationName?;
|};

public type IdentityProvider record {|
    readonly string idpID;
    string id;
    string name;
    string 'type;
    string issuer;
    string clientId;
    string clientSecret;
    string organizationOrgId;
|};

public type IdentityProviderOptionalized record {|
    string idpID?;
    string id?;
    string name?;
    string 'type?;
    string issuer?;
    string clientId?;
    string clientSecret?;
    string organizationOrgId?;
|};

public type IdentityProviderWithRelations record {|
    *IdentityProviderOptionalized;
    OrganizationOptionalized organization?;
|};

public type IdentityProviderTargetType typedesc<IdentityProviderWithRelations>;

public type IdentityProviderInsert IdentityProvider;

public type IdentityProviderUpdate record {|
    string id?;
    string name?;
    string 'type?;
    string issuer?;
    string clientId?;
    string clientSecret?;
    string organizationOrgId?;
|};

public type Application record {|
    readonly string appId;
    string applicationName;
    string sandBoxKey;
    string productionKey;

    string addedAPIs;

    string idpId;
|};

public type ApplicationOptionalized record {|
    string appId?;
    string applicationName?;
    string sandBoxKey?;
    string productionKey?;
    string addedAPIs?;
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
    string addedAPIs?;
    string idpId?;
|};

public type Organization record {|
    readonly string orgId;
    string organizationName;
    boolean isPublic;
    string authenticatedPages;

|};

public type OrganizationOptionalized record {|
    string orgId?;
    string organizationName?;
    boolean isPublic?;
    string authenticatedPages?;
|};

public type OrganizationWithRelations record {|
    *OrganizationOptionalized;
    OrganizationAssetsOptionalized[] organizationAssets?;
    IdentityProviderOptionalized[] identityProvider?;
    SubscriptionOptionalized[] subscriptions?;
    OrgImagesOptionalized[] orgImages?;
|};

public type OrganizationTargetType typedesc<OrganizationWithRelations>;

public type OrganizationInsert Organization;

public type OrganizationUpdate record {|
    string organizationName?;
    boolean isPublic?;
    string authenticatedPages?;
|};

public type OrganizationAssets record {|
    readonly string pageType;
    string pageContent;
    string organizationOrgId;
|};

public type OrganizationAssetsOptionalized record {|
    string pageType?;
    string pageContent?;
    string organizationOrgId?;
|};

public type OrganizationAssetsWithRelations record {|
    *OrganizationAssetsOptionalized;
    OrganizationOptionalized organization?;
|};

public type OrganizationAssetsTargetType typedesc<OrganizationAssetsWithRelations>;

public type OrganizationAssetsInsert OrganizationAssets;

public type OrganizationAssetsUpdate record {|
    string pageType?;
    string pageContent?;
    string organizationOrgId?;
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
    ReviewOptionalized[] reviews?;
    SubscriptionOptionalized[] subscriptions?;
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
    string apiApiId;
    string apiOrganizationName;
    string userUserId;
    string organizationOrgId;
    string subscriptionPolicyId;
|};

public type SubscriptionOptionalized record {|
    string subscriptionId?;
    string apiApiId?;
    string apiOrganizationName?;
    string userUserId?;
    string organizationOrgId?;
    string subscriptionPolicyId?;
|};

public type SubscriptionWithRelations record {|
    *SubscriptionOptionalized;
    ApiMetadataOptionalized api?;
    UserOptionalized user?;
    OrganizationOptionalized organization?;
    ThrottlingPolicyOptionalized subscriptionPolicy?;
|};

public type SubscriptionTargetType typedesc<SubscriptionWithRelations>;

public type SubscriptionInsert Subscription;

public type SubscriptionUpdate record {|
    string apiApiId?;
    string apiOrganizationName?;
    string userUserId?;
    string organizationOrgId?;
    string subscriptionPolicyId?;
|};

