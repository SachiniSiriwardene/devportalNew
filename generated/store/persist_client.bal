// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.inmemory;

const THROTTLING_POLICY = "throttlingpolicies";
const RATE_LIMITING_POLICY = "ratelimitingpolicies";
const REVIEW = "reviews";
const API_METADATA = "apimetadata";
const ADDITIONAL_PROPERTIES = "additionalproperties";
const IDENTITY_PROVIDER = "identityproviders";
const THEME = "themes";
const APPLICATION = "applications";
const ORGANIZATION = "organizations";
const ORGANIZATION_ASSETS = "organizationassets";
const A_P_I_ASSETS = "apiassets";
const APPLICATION_PROPERTIES = "applicationproperties";
const USER = "users";
const SUBSCRIPTION = "subscriptions";
final isolated table<ThrottlingPolicy> key(policyId) throttlingpoliciesTable = table [];
final isolated table<RateLimitingPolicy> key(policyId) ratelimitingpoliciesTable = table [];
final isolated table<Review> key(reviewId) reviewsTable = table [];
final isolated table<ApiMetadata> key(apiId) apimetadataTable = table [];
final isolated table<AdditionalProperties> key(propertyId) additionalpropertiesTable = table [];
final isolated table<IdentityProvider> key(idpID) identityprovidersTable = table [];
final isolated table<Theme> key(themeId) themesTable = table [];
final isolated table<Application> key(appId) applicationsTable = table [];
final isolated table<Organization> key(orgId) organizationsTable = table [];
final isolated table<OrganizationAssets> key(assetId) organizationassetsTable = table [];
final isolated table<APIAssets> key(assetId) apiassetsTable = table [];
final isolated table<ApplicationProperties> key(propertyId) applicationpropertiesTable = table [];
final isolated table<User> key(userId) usersTable = table [];
final isolated table<Subscription> key(subscriptionId) subscriptionsTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [THROTTLING_POLICY] : {
                keyFields: ["policyId"],
                query: queryThrottlingpolicies,
                queryOne: queryOneThrottlingpolicies
            },
            [RATE_LIMITING_POLICY] : {
                keyFields: ["policyId"],
                query: queryRatelimitingpolicies,
                queryOne: queryOneRatelimitingpolicies
            },
            [REVIEW] : {
                keyFields: ["reviewId"],
                query: queryReviews,
                queryOne: queryOneReviews
            },
            [API_METADATA] : {
                keyFields: ["apiId"],
                query: queryApimetadata,
                queryOne: queryOneApimetadata,
                associationsMethods: {
                    "additionalProperties": queryApiMetadataAdditionalproperties,
                    "throttlingPolicies": queryApiMetadataThrottlingpolicies,
                    "reviews": queryApiMetadataReviews,
                    "subscriptions": queryApiMetadataSubscriptions
                }
            },
            [ADDITIONAL_PROPERTIES] : {
                keyFields: ["propertyId"],
                query: queryAdditionalproperties,
                queryOne: queryOneAdditionalproperties
            },
            [IDENTITY_PROVIDER] : {
                keyFields: ["idpID"],
                query: queryIdentityproviders,
                queryOne: queryOneIdentityproviders
            },
            [THEME] : {
                keyFields: ["themeId"],
                query: queryThemes,
                queryOne: queryOneThemes
            },
            [APPLICATION] : {
                keyFields: ["appId"],
                query: queryApplications,
                queryOne: queryOneApplications,
                associationsMethods: {
                    "appProperties": queryApplicationAppproperties,
                    "accessControl": queryApplicationAccesscontrol
                }
            },
            [ORGANIZATION] : {
                keyFields: ["orgId"],
                query: queryOrganizations,
                queryOne: queryOneOrganizations,
                associationsMethods: {
                    "theme": queryOrganizationTheme,
                    "identityProvider": queryOrganizationIdentityprovider,
                    "subscriptions": queryOrganizationSubscriptions
                }
            },
            [ORGANIZATION_ASSETS] : {
                keyFields: ["assetId"],
                query: queryOrganizationassets,
                queryOne: queryOneOrganizationassets
            },
            [A_P_I_ASSETS] : {
                keyFields: ["assetId"],
                query: queryApiassets,
                queryOne: queryOneApiassets
            },
            [APPLICATION_PROPERTIES] : {
                keyFields: ["propertyId"],
                query: queryApplicationproperties,
                queryOne: queryOneApplicationproperties
            },
            [USER] : {
                keyFields: ["userId"],
                query: queryUsers,
                queryOne: queryOneUsers,
                associationsMethods: {
                    "reviews": queryUserReviews,
                    "subscriptions": queryUserSubscriptions
                }
            },
            [SUBSCRIPTION] : {
                keyFields: ["subscriptionId"],
                query: querySubscriptions,
                queryOne: queryOneSubscriptions
            }
        };
        self.persistClients = {
            [THROTTLING_POLICY] : check new (metadata.get(THROTTLING_POLICY).cloneReadOnly()),
            [RATE_LIMITING_POLICY] : check new (metadata.get(RATE_LIMITING_POLICY).cloneReadOnly()),
            [REVIEW] : check new (metadata.get(REVIEW).cloneReadOnly()),
            [API_METADATA] : check new (metadata.get(API_METADATA).cloneReadOnly()),
            [ADDITIONAL_PROPERTIES] : check new (metadata.get(ADDITIONAL_PROPERTIES).cloneReadOnly()),
            [IDENTITY_PROVIDER] : check new (metadata.get(IDENTITY_PROVIDER).cloneReadOnly()),
            [THEME] : check new (metadata.get(THEME).cloneReadOnly()),
            [APPLICATION] : check new (metadata.get(APPLICATION).cloneReadOnly()),
            [ORGANIZATION] : check new (metadata.get(ORGANIZATION).cloneReadOnly()),
            [ORGANIZATION_ASSETS] : check new (metadata.get(ORGANIZATION_ASSETS).cloneReadOnly()),
            [A_P_I_ASSETS] : check new (metadata.get(A_P_I_ASSETS).cloneReadOnly()),
            [APPLICATION_PROPERTIES] : check new (metadata.get(APPLICATION_PROPERTIES).cloneReadOnly()),
            [USER] : check new (metadata.get(USER).cloneReadOnly()),
            [SUBSCRIPTION] : check new (metadata.get(SUBSCRIPTION).cloneReadOnly())
        };
    }

    isolated resource function get throttlingpolicies(ThrottlingPolicyTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get throttlingpolicies/[string policyId](ThrottlingPolicyTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post throttlingpolicies(ThrottlingPolicyInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ThrottlingPolicyInsert value in data {
            lock {
                if throttlingpoliciesTable.hasKey(value.policyId) {
                    return persist:getAlreadyExistsError("ThrottlingPolicy", value.policyId);
                }
                throttlingpoliciesTable.put(value.clone());
            }
            keys.push(value.policyId);
        }
        return keys;
    }

    isolated resource function put throttlingpolicies/[string policyId](ThrottlingPolicyUpdate value) returns ThrottlingPolicy|persist:Error {
        lock {
            if !throttlingpoliciesTable.hasKey(policyId) {
                return persist:getNotFoundError("ThrottlingPolicy", policyId);
            }
            ThrottlingPolicy throttlingpolicy = throttlingpoliciesTable.get(policyId);
            foreach var [k, v] in value.clone().entries() {
                throttlingpolicy[k] = v;
            }
            throttlingpoliciesTable.put(throttlingpolicy);
            return throttlingpolicy.clone();
        }
    }

    isolated resource function delete throttlingpolicies/[string policyId]() returns ThrottlingPolicy|persist:Error {
        lock {
            if !throttlingpoliciesTable.hasKey(policyId) {
                return persist:getNotFoundError("ThrottlingPolicy", policyId);
            }
            return throttlingpoliciesTable.remove(policyId).clone();
        }
    }

    isolated resource function get ratelimitingpolicies(RateLimitingPolicyTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get ratelimitingpolicies/[string policyId](RateLimitingPolicyTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post ratelimitingpolicies(RateLimitingPolicyInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach RateLimitingPolicyInsert value in data {
            lock {
                if ratelimitingpoliciesTable.hasKey(value.policyId) {
                    return persist:getAlreadyExistsError("RateLimitingPolicy", value.policyId);
                }
                ratelimitingpoliciesTable.put(value.clone());
            }
            keys.push(value.policyId);
        }
        return keys;
    }

    isolated resource function put ratelimitingpolicies/[string policyId](RateLimitingPolicyUpdate value) returns RateLimitingPolicy|persist:Error {
        lock {
            if !ratelimitingpoliciesTable.hasKey(policyId) {
                return persist:getNotFoundError("RateLimitingPolicy", policyId);
            }
            RateLimitingPolicy ratelimitingpolicy = ratelimitingpoliciesTable.get(policyId);
            foreach var [k, v] in value.clone().entries() {
                ratelimitingpolicy[k] = v;
            }
            ratelimitingpoliciesTable.put(ratelimitingpolicy);
            return ratelimitingpolicy.clone();
        }
    }

    isolated resource function delete ratelimitingpolicies/[string policyId]() returns RateLimitingPolicy|persist:Error {
        lock {
            if !ratelimitingpoliciesTable.hasKey(policyId) {
                return persist:getNotFoundError("RateLimitingPolicy", policyId);
            }
            return ratelimitingpoliciesTable.remove(policyId).clone();
        }
    }

    isolated resource function get reviews(ReviewTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get reviews/[string reviewId](ReviewTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post reviews(ReviewInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ReviewInsert value in data {
            lock {
                if reviewsTable.hasKey(value.reviewId) {
                    return persist:getAlreadyExistsError("Review", value.reviewId);
                }
                reviewsTable.put(value.clone());
            }
            keys.push(value.reviewId);
        }
        return keys;
    }

    isolated resource function put reviews/[string reviewId](ReviewUpdate value) returns Review|persist:Error {
        lock {
            if !reviewsTable.hasKey(reviewId) {
                return persist:getNotFoundError("Review", reviewId);
            }
            Review review = reviewsTable.get(reviewId);
            foreach var [k, v] in value.clone().entries() {
                review[k] = v;
            }
            reviewsTable.put(review);
            return review.clone();
        }
    }

    isolated resource function delete reviews/[string reviewId]() returns Review|persist:Error {
        lock {
            if !reviewsTable.hasKey(reviewId) {
                return persist:getNotFoundError("Review", reviewId);
            }
            return reviewsTable.remove(reviewId).clone();
        }
    }

    isolated resource function get apimetadata(ApiMetadataTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get apimetadata/[string apiId](ApiMetadataTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post apimetadata(ApiMetadataInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ApiMetadataInsert value in data {
            lock {
                if apimetadataTable.hasKey(value.apiId) {
                    return persist:getAlreadyExistsError("ApiMetadata", value.apiId);
                }
                apimetadataTable.put(value.clone());
            }
            keys.push(value.apiId);
        }
        return keys;
    }

    isolated resource function put apimetadata/[string apiId](ApiMetadataUpdate value) returns ApiMetadata|persist:Error {
        lock {
            if !apimetadataTable.hasKey(apiId) {
                return persist:getNotFoundError("ApiMetadata", apiId);
            }
            ApiMetadata apimetadata = apimetadataTable.get(apiId);
            foreach var [k, v] in value.clone().entries() {
                apimetadata[k] = v;
            }
            apimetadataTable.put(apimetadata);
            return apimetadata.clone();
        }
    }

    isolated resource function delete apimetadata/[string apiId]() returns ApiMetadata|persist:Error {
        lock {
            if !apimetadataTable.hasKey(apiId) {
                return persist:getNotFoundError("ApiMetadata", apiId);
            }
            return apimetadataTable.remove(apiId).clone();
        }
    }

    isolated resource function get additionalproperties(AdditionalPropertiesTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get additionalproperties/[string propertyId](AdditionalPropertiesTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post additionalproperties(AdditionalPropertiesInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach AdditionalPropertiesInsert value in data {
            lock {
                if additionalpropertiesTable.hasKey(value.propertyId) {
                    return persist:getAlreadyExistsError("AdditionalProperties", value.propertyId);
                }
                additionalpropertiesTable.put(value.clone());
            }
            keys.push(value.propertyId);
        }
        return keys;
    }

    isolated resource function put additionalproperties/[string propertyId](AdditionalPropertiesUpdate value) returns AdditionalProperties|persist:Error {
        lock {
            if !additionalpropertiesTable.hasKey(propertyId) {
                return persist:getNotFoundError("AdditionalProperties", propertyId);
            }
            AdditionalProperties additionalproperties = additionalpropertiesTable.get(propertyId);
            foreach var [k, v] in value.clone().entries() {
                additionalproperties[k] = v;
            }
            additionalpropertiesTable.put(additionalproperties);
            return additionalproperties.clone();
        }
    }

    isolated resource function delete additionalproperties/[string propertyId]() returns AdditionalProperties|persist:Error {
        lock {
            if !additionalpropertiesTable.hasKey(propertyId) {
                return persist:getNotFoundError("AdditionalProperties", propertyId);
            }
            return additionalpropertiesTable.remove(propertyId).clone();
        }
    }

    isolated resource function get identityproviders(IdentityProviderTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get identityproviders/[string idpID](IdentityProviderTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post identityproviders(IdentityProviderInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach IdentityProviderInsert value in data {
            lock {
                if identityprovidersTable.hasKey(value.idpID) {
                    return persist:getAlreadyExistsError("IdentityProvider", value.idpID);
                }
                identityprovidersTable.put(value.clone());
            }
            keys.push(value.idpID);
        }
        return keys;
    }

    isolated resource function put identityproviders/[string idpID](IdentityProviderUpdate value) returns IdentityProvider|persist:Error {
        lock {
            if !identityprovidersTable.hasKey(idpID) {
                return persist:getNotFoundError("IdentityProvider", idpID);
            }
            IdentityProvider identityprovider = identityprovidersTable.get(idpID);
            foreach var [k, v] in value.clone().entries() {
                identityprovider[k] = v;
            }
            identityprovidersTable.put(identityprovider);
            return identityprovider.clone();
        }
    }

    isolated resource function delete identityproviders/[string idpID]() returns IdentityProvider|persist:Error {
        lock {
            if !identityprovidersTable.hasKey(idpID) {
                return persist:getNotFoundError("IdentityProvider", idpID);
            }
            return identityprovidersTable.remove(idpID).clone();
        }
    }

    isolated resource function get themes(ThemeTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get themes/[string themeId](ThemeTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post themes(ThemeInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ThemeInsert value in data {
            lock {
                if themesTable.hasKey(value.themeId) {
                    return persist:getAlreadyExistsError("Theme", value.themeId);
                }
                themesTable.put(value.clone());
            }
            keys.push(value.themeId);
        }
        return keys;
    }

    isolated resource function put themes/[string themeId](ThemeUpdate value) returns Theme|persist:Error {
        lock {
            if !themesTable.hasKey(themeId) {
                return persist:getNotFoundError("Theme", themeId);
            }
            Theme theme = themesTable.get(themeId);
            foreach var [k, v] in value.clone().entries() {
                theme[k] = v;
            }
            themesTable.put(theme);
            return theme.clone();
        }
    }

    isolated resource function delete themes/[string themeId]() returns Theme|persist:Error {
        lock {
            if !themesTable.hasKey(themeId) {
                return persist:getNotFoundError("Theme", themeId);
            }
            return themesTable.remove(themeId).clone();
        }
    }

    isolated resource function get applications(ApplicationTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get applications/[string appId](ApplicationTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post applications(ApplicationInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ApplicationInsert value in data {
            lock {
                if applicationsTable.hasKey(value.appId) {
                    return persist:getAlreadyExistsError("Application", value.appId);
                }
                applicationsTable.put(value.clone());
            }
            keys.push(value.appId);
        }
        return keys;
    }

    isolated resource function put applications/[string appId](ApplicationUpdate value) returns Application|persist:Error {
        lock {
            if !applicationsTable.hasKey(appId) {
                return persist:getNotFoundError("Application", appId);
            }
            Application application = applicationsTable.get(appId);
            foreach var [k, v] in value.clone().entries() {
                application[k] = v;
            }
            applicationsTable.put(application);
            return application.clone();
        }
    }

    isolated resource function delete applications/[string appId]() returns Application|persist:Error {
        lock {
            if !applicationsTable.hasKey(appId) {
                return persist:getNotFoundError("Application", appId);
            }
            return applicationsTable.remove(appId).clone();
        }
    }

    isolated resource function get organizations(OrganizationTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get organizations/[string orgId](OrganizationTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post organizations(OrganizationInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach OrganizationInsert value in data {
            lock {
                if organizationsTable.hasKey(value.orgId) {
                    return persist:getAlreadyExistsError("Organization", value.orgId);
                }
                organizationsTable.put(value.clone());
            }
            keys.push(value.orgId);
        }
        return keys;
    }

    isolated resource function put organizations/[string orgId](OrganizationUpdate value) returns Organization|persist:Error {
        lock {
            if !organizationsTable.hasKey(orgId) {
                return persist:getNotFoundError("Organization", orgId);
            }
            Organization organization = organizationsTable.get(orgId);
            foreach var [k, v] in value.clone().entries() {
                organization[k] = v;
            }
            organizationsTable.put(organization);
            return organization.clone();
        }
    }

    isolated resource function delete organizations/[string orgId]() returns Organization|persist:Error {
        lock {
            if !organizationsTable.hasKey(orgId) {
                return persist:getNotFoundError("Organization", orgId);
            }
            return organizationsTable.remove(orgId).clone();
        }
    }

    isolated resource function get organizationassets(OrganizationAssetsTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get organizationassets/[string assetId](OrganizationAssetsTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post organizationassets(OrganizationAssetsInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach OrganizationAssetsInsert value in data {
            lock {
                if organizationassetsTable.hasKey(value.assetId) {
                    return persist:getAlreadyExistsError("OrganizationAssets", value.assetId);
                }
                organizationassetsTable.put(value.clone());
            }
            keys.push(value.assetId);
        }
        return keys;
    }

    isolated resource function put organizationassets/[string assetId](OrganizationAssetsUpdate value) returns OrganizationAssets|persist:Error {
        lock {
            if !organizationassetsTable.hasKey(assetId) {
                return persist:getNotFoundError("OrganizationAssets", assetId);
            }
            OrganizationAssets organizationassets = organizationassetsTable.get(assetId);
            foreach var [k, v] in value.clone().entries() {
                organizationassets[k] = v;
            }
            organizationassetsTable.put(organizationassets);
            return organizationassets.clone();
        }
    }

    isolated resource function delete organizationassets/[string assetId]() returns OrganizationAssets|persist:Error {
        lock {
            if !organizationassetsTable.hasKey(assetId) {
                return persist:getNotFoundError("OrganizationAssets", assetId);
            }
            return organizationassetsTable.remove(assetId).clone();
        }
    }

    isolated resource function get apiassets(APIAssetsTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get apiassets/[string assetId](APIAssetsTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post apiassets(APIAssetsInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach APIAssetsInsert value in data {
            lock {
                if apiassetsTable.hasKey(value.assetId) {
                    return persist:getAlreadyExistsError("APIAssets", value.assetId);
                }
                apiassetsTable.put(value.clone());
            }
            keys.push(value.assetId);
        }
        return keys;
    }

    isolated resource function put apiassets/[string assetId](APIAssetsUpdate value) returns APIAssets|persist:Error {
        lock {
            if !apiassetsTable.hasKey(assetId) {
                return persist:getNotFoundError("APIAssets", assetId);
            }
            APIAssets apiassets = apiassetsTable.get(assetId);
            foreach var [k, v] in value.clone().entries() {
                apiassets[k] = v;
            }
            apiassetsTable.put(apiassets);
            return apiassets.clone();
        }
    }

    isolated resource function delete apiassets/[string assetId]() returns APIAssets|persist:Error {
        lock {
            if !apiassetsTable.hasKey(assetId) {
                return persist:getNotFoundError("APIAssets", assetId);
            }
            return apiassetsTable.remove(assetId).clone();
        }
    }

    isolated resource function get applicationproperties(ApplicationPropertiesTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get applicationproperties/[string propertyId](ApplicationPropertiesTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post applicationproperties(ApplicationPropertiesInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach ApplicationPropertiesInsert value in data {
            lock {
                if applicationpropertiesTable.hasKey(value.propertyId) {
                    return persist:getAlreadyExistsError("ApplicationProperties", value.propertyId);
                }
                applicationpropertiesTable.put(value.clone());
            }
            keys.push(value.propertyId);
        }
        return keys;
    }

    isolated resource function put applicationproperties/[string propertyId](ApplicationPropertiesUpdate value) returns ApplicationProperties|persist:Error {
        lock {
            if !applicationpropertiesTable.hasKey(propertyId) {
                return persist:getNotFoundError("ApplicationProperties", propertyId);
            }
            ApplicationProperties applicationproperties = applicationpropertiesTable.get(propertyId);
            foreach var [k, v] in value.clone().entries() {
                applicationproperties[k] = v;
            }
            applicationpropertiesTable.put(applicationproperties);
            return applicationproperties.clone();
        }
    }

    isolated resource function delete applicationproperties/[string propertyId]() returns ApplicationProperties|persist:Error {
        lock {
            if !applicationpropertiesTable.hasKey(propertyId) {
                return persist:getNotFoundError("ApplicationProperties", propertyId);
            }
            return applicationpropertiesTable.remove(propertyId).clone();
        }
    }

    isolated resource function get users(UserTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get users/[string userId](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach UserInsert value in data {
            lock {
                if usersTable.hasKey(value.userId) {
                    return persist:getAlreadyExistsError("User", value.userId);
                }
                usersTable.put(value.clone());
            }
            keys.push(value.userId);
        }
        return keys;
    }

    isolated resource function put users/[string userId](UserUpdate value) returns User|persist:Error {
        lock {
            if !usersTable.hasKey(userId) {
                return persist:getNotFoundError("User", userId);
            }
            User user = usersTable.get(userId);
            foreach var [k, v] in value.clone().entries() {
                user[k] = v;
            }
            usersTable.put(user);
            return user.clone();
        }
    }

    isolated resource function delete users/[string userId]() returns User|persist:Error {
        lock {
            if !usersTable.hasKey(userId) {
                return persist:getNotFoundError("User", userId);
            }
            return usersTable.remove(userId).clone();
        }
    }

    isolated resource function get subscriptions(SubscriptionTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get subscriptions/[string subscriptionId](SubscriptionTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post subscriptions(SubscriptionInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach SubscriptionInsert value in data {
            lock {
                if subscriptionsTable.hasKey(value.subscriptionId) {
                    return persist:getAlreadyExistsError("Subscription", value.subscriptionId);
                }
                subscriptionsTable.put(value.clone());
            }
            keys.push(value.subscriptionId);
        }
        return keys;
    }

    isolated resource function put subscriptions/[string subscriptionId](SubscriptionUpdate value) returns Subscription|persist:Error {
        lock {
            if !subscriptionsTable.hasKey(subscriptionId) {
                return persist:getNotFoundError("Subscription", subscriptionId);
            }
            Subscription subscription = subscriptionsTable.get(subscriptionId);
            foreach var [k, v] in value.clone().entries() {
                subscription[k] = v;
            }
            subscriptionsTable.put(subscription);
            return subscription.clone();
        }
    }

    isolated resource function delete subscriptions/[string subscriptionId]() returns Subscription|persist:Error {
        lock {
            if !subscriptionsTable.hasKey(subscriptionId) {
                return persist:getNotFoundError("Subscription", subscriptionId);
            }
            return subscriptionsTable.remove(subscriptionId).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryThrottlingpolicies(string[] fields) returns stream<record {}, persist:Error?> {
    table<ThrottlingPolicy> key(policyId) throttlingpoliciesClonedTable;
    lock {
        throttlingpoliciesClonedTable = throttlingpoliciesTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    return from record {} 'object in throttlingpoliciesClonedTable
        outer join var apimetadata in apimetadataClonedTable on ['object.apimetadataApiId] equals [apimetadata?.apiId]
        select persist:filterRecord({
            ...'object,
            "apimetadata": apimetadata
        }, fields);
}

isolated function queryOneThrottlingpolicies(anydata key) returns record {}|persist:NotFoundError {
    table<ThrottlingPolicy> key(policyId) throttlingpoliciesClonedTable;
    lock {
        throttlingpoliciesClonedTable = throttlingpoliciesTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    from record {} 'object in throttlingpoliciesClonedTable
    where persist:getKey('object, ["policyId"]) == key
    outer join var apimetadata in apimetadataClonedTable on ['object.apimetadataApiId] equals [apimetadata?.apiId]
    do {
        return {
            ...'object,
            "apimetadata": apimetadata
        };
    };
    return persist:getNotFoundError("ThrottlingPolicy", key);
}

isolated function queryRatelimitingpolicies(string[] fields) returns stream<record {}, persist:Error?> {
    table<RateLimitingPolicy> key(policyId) ratelimitingpoliciesClonedTable;
    lock {
        ratelimitingpoliciesClonedTable = ratelimitingpoliciesTable.clone();
    }
    return from record {} 'object in ratelimitingpoliciesClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneRatelimitingpolicies(anydata key) returns record {}|persist:NotFoundError {
    table<RateLimitingPolicy> key(policyId) ratelimitingpoliciesClonedTable;
    lock {
        ratelimitingpoliciesClonedTable = ratelimitingpoliciesTable.clone();
    }
    from record {} 'object in ratelimitingpoliciesClonedTable
    where persist:getKey('object, ["policyId"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("RateLimitingPolicy", key);
}

isolated function queryReviews(string[] fields) returns stream<record {}, persist:Error?> {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    return from record {} 'object in reviewsClonedTable
        outer join var apifeedback in apimetadataClonedTable on ['object.apifeedbackApiId] equals [apifeedback?.apiId]
        outer join var reviewedby in usersClonedTable on ['object.reviewedbyUserId] equals [reviewedby?.userId]
        select persist:filterRecord({
            ...'object,
            "apiFeedback": apifeedback,
            "reviewedBy": reviewedby
        }, fields);
}

isolated function queryOneReviews(anydata key) returns record {}|persist:NotFoundError {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    from record {} 'object in reviewsClonedTable
    where persist:getKey('object, ["reviewId"]) == key
    outer join var apifeedback in apimetadataClonedTable on ['object.apifeedbackApiId] equals [apifeedback?.apiId]
    outer join var reviewedby in usersClonedTable on ['object.reviewedbyUserId] equals [reviewedby?.userId]
    do {
        return {
            ...'object,
            "apiFeedback": apifeedback,
            "reviewedBy": reviewedby
        };
    };
    return persist:getNotFoundError("Review", key);
}

isolated function queryApimetadata(string[] fields) returns stream<record {}, persist:Error?> {
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    return from record {} 'object in apimetadataClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneApimetadata(anydata key) returns record {}|persist:NotFoundError {
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    from record {} 'object in apimetadataClonedTable
    where persist:getKey('object, ["apiId"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("ApiMetadata", key);
}

isolated function queryAdditionalproperties(string[] fields) returns stream<record {}, persist:Error?> {
    table<AdditionalProperties> key(propertyId) additionalpropertiesClonedTable;
    lock {
        additionalpropertiesClonedTable = additionalpropertiesTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    return from record {} 'object in additionalpropertiesClonedTable
        outer join var apimetadata in apimetadataClonedTable on ['object.apimetadataApiId] equals [apimetadata?.apiId]
        select persist:filterRecord({
            ...'object,
            "apimetadata": apimetadata
        }, fields);
}

isolated function queryOneAdditionalproperties(anydata key) returns record {}|persist:NotFoundError {
    table<AdditionalProperties> key(propertyId) additionalpropertiesClonedTable;
    lock {
        additionalpropertiesClonedTable = additionalpropertiesTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    from record {} 'object in additionalpropertiesClonedTable
    where persist:getKey('object, ["propertyId"]) == key
    outer join var apimetadata in apimetadataClonedTable on ['object.apimetadataApiId] equals [apimetadata?.apiId]
    do {
        return {
            ...'object,
            "apimetadata": apimetadata
        };
    };
    return persist:getNotFoundError("AdditionalProperties", key);
}

isolated function queryIdentityproviders(string[] fields) returns stream<record {}, persist:Error?> {
    table<IdentityProvider> key(idpID) identityprovidersClonedTable;
    lock {
        identityprovidersClonedTable = identityprovidersTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    return from record {} 'object in identityprovidersClonedTable
        outer join var organization in organizationsClonedTable on ['object.organizationOrgId] equals [organization?.orgId]
        select persist:filterRecord({
            ...'object,
            "organization": organization
        }, fields);
}

isolated function queryOneIdentityproviders(anydata key) returns record {}|persist:NotFoundError {
    table<IdentityProvider> key(idpID) identityprovidersClonedTable;
    lock {
        identityprovidersClonedTable = identityprovidersTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    from record {} 'object in identityprovidersClonedTable
    where persist:getKey('object, ["idpID"]) == key
    outer join var organization in organizationsClonedTable on ['object.organizationOrgId] equals [organization?.orgId]
    do {
        return {
            ...'object,
            "organization": organization
        };
    };
    return persist:getNotFoundError("IdentityProvider", key);
}

isolated function queryThemes(string[] fields) returns stream<record {}, persist:Error?> {
    table<Theme> key(themeId) themesClonedTable;
    lock {
        themesClonedTable = themesTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    return from record {} 'object in themesClonedTable
        outer join var organization in organizationsClonedTable on ['object.organizationOrgId] equals [organization?.orgId]
        select persist:filterRecord({
            ...'object,
            "organization": organization
        }, fields);
}

isolated function queryOneThemes(anydata key) returns record {}|persist:NotFoundError {
    table<Theme> key(themeId) themesClonedTable;
    lock {
        themesClonedTable = themesTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    from record {} 'object in themesClonedTable
    where persist:getKey('object, ["themeId"]) == key
    outer join var organization in organizationsClonedTable on ['object.organizationOrgId] equals [organization?.orgId]
    do {
        return {
            ...'object,
            "organization": organization
        };
    };
    return persist:getNotFoundError("Theme", key);
}

isolated function queryApplications(string[] fields) returns stream<record {}, persist:Error?> {
    table<Application> key(appId) applicationsClonedTable;
    lock {
        applicationsClonedTable = applicationsTable.clone();
    }
    return from record {} 'object in applicationsClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneApplications(anydata key) returns record {}|persist:NotFoundError {
    table<Application> key(appId) applicationsClonedTable;
    lock {
        applicationsClonedTable = applicationsTable.clone();
    }
    from record {} 'object in applicationsClonedTable
    where persist:getKey('object, ["appId"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Application", key);
}

isolated function queryOrganizations(string[] fields) returns stream<record {}, persist:Error?> {
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    return from record {} 'object in organizationsClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneOrganizations(anydata key) returns record {}|persist:NotFoundError {
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    from record {} 'object in organizationsClonedTable
    where persist:getKey('object, ["orgId"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Organization", key);
}

isolated function queryOrganizationassets(string[] fields) returns stream<record {}, persist:Error?> {
    table<OrganizationAssets> key(assetId) organizationassetsClonedTable;
    lock {
        organizationassetsClonedTable = organizationassetsTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    return from record {} 'object in organizationassetsClonedTable
        outer join var organization in organizationsClonedTable on ['object.organizationassetsOrgId] equals [organization?.orgId]
        select persist:filterRecord({
            ...'object,
            "organization": organization
        }, fields);
}

isolated function queryOneOrganizationassets(anydata key) returns record {}|persist:NotFoundError {
    table<OrganizationAssets> key(assetId) organizationassetsClonedTable;
    lock {
        organizationassetsClonedTable = organizationassetsTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    from record {} 'object in organizationassetsClonedTable
    where persist:getKey('object, ["assetId"]) == key
    outer join var organization in organizationsClonedTable on ['object.organizationassetsOrgId] equals [organization?.orgId]
    do {
        return {
            ...'object,
            "organization": organization
        };
    };
    return persist:getNotFoundError("OrganizationAssets", key);
}

isolated function queryApiassets(string[] fields) returns stream<record {}, persist:Error?> {
    table<APIAssets> key(assetId) apiassetsClonedTable;
    lock {
        apiassetsClonedTable = apiassetsTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    return from record {} 'object in apiassetsClonedTable
        outer join var api in apimetadataClonedTable on ['object.assetmappingsApiId] equals [api?.apiId]
        select persist:filterRecord({
            ...'object,
            "api": api
        }, fields);
}

isolated function queryOneApiassets(anydata key) returns record {}|persist:NotFoundError {
    table<APIAssets> key(assetId) apiassetsClonedTable;
    lock {
        apiassetsClonedTable = apiassetsTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    from record {} 'object in apiassetsClonedTable
    where persist:getKey('object, ["assetId"]) == key
    outer join var api in apimetadataClonedTable on ['object.assetmappingsApiId] equals [api?.apiId]
    do {
        return {
            ...'object,
            "api": api
        };
    };
    return persist:getNotFoundError("APIAssets", key);
}

isolated function queryApplicationproperties(string[] fields) returns stream<record {}, persist:Error?> {
    table<ApplicationProperties> key(propertyId) applicationpropertiesClonedTable;
    lock {
        applicationpropertiesClonedTable = applicationpropertiesTable.clone();
    }
    table<Application> key(appId) applicationsClonedTable;
    lock {
        applicationsClonedTable = applicationsTable.clone();
    }
    return from record {} 'object in applicationpropertiesClonedTable
        outer join var application in applicationsClonedTable on ['object.applicationAppId] equals [application?.appId]
        select persist:filterRecord({
            ...'object,
            "application": application
        }, fields);
}

isolated function queryOneApplicationproperties(anydata key) returns record {}|persist:NotFoundError {
    table<ApplicationProperties> key(propertyId) applicationpropertiesClonedTable;
    lock {
        applicationpropertiesClonedTable = applicationpropertiesTable.clone();
    }
    table<Application> key(appId) applicationsClonedTable;
    lock {
        applicationsClonedTable = applicationsTable.clone();
    }
    from record {} 'object in applicationpropertiesClonedTable
    where persist:getKey('object, ["propertyId"]) == key
    outer join var application in applicationsClonedTable on ['object.applicationAppId] equals [application?.appId]
    do {
        return {
            ...'object,
            "application": application
        };
    };
    return persist:getNotFoundError("ApplicationProperties", key);
}

isolated function queryUsers(string[] fields) returns stream<record {}, persist:Error?> {
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    table<Application> key(appId) applicationsClonedTable;
    lock {
        applicationsClonedTable = applicationsTable.clone();
    }
    return from record {} 'object in usersClonedTable
        outer join var application in applicationsClonedTable on ['object.applicationAppId] equals [application?.appId]
        select persist:filterRecord({
            ...'object,
            "application": application
        }, fields);
}

isolated function queryOneUsers(anydata key) returns record {}|persist:NotFoundError {
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    table<Application> key(appId) applicationsClonedTable;
    lock {
        applicationsClonedTable = applicationsTable.clone();
    }
    from record {} 'object in usersClonedTable
    where persist:getKey('object, ["userId"]) == key
    outer join var application in applicationsClonedTable on ['object.applicationAppId] equals [application?.appId]
    do {
        return {
            ...'object,
            "application": application
        };
    };
    return persist:getNotFoundError("User", key);
}

isolated function querySubscriptions(string[] fields) returns stream<record {}, persist:Error?> {
    table<Subscription> key(subscriptionId) subscriptionsClonedTable;
    lock {
        subscriptionsClonedTable = subscriptionsTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    table<ThrottlingPolicy> key(policyId) throttlingpoliciesClonedTable;
    lock {
        throttlingpoliciesClonedTable = throttlingpoliciesTable.clone();
    }
    return from record {} 'object in subscriptionsClonedTable
        outer join var api in apimetadataClonedTable on ['object.apiApiId] equals [api?.apiId]
        outer join var user in usersClonedTable on ['object.userUserId] equals [user?.userId]
        outer join var organization in organizationsClonedTable on ['object.organizationOrgId] equals [organization?.orgId]
        outer join var subscriptionpolicy in throttlingpoliciesClonedTable on ['object.subscriptionPolicyId] equals [subscriptionpolicy?.policyId]
        select persist:filterRecord({
            ...'object,
            "api": api,
            "user": user,
            "organization": organization,
            "subscriptionPolicy": subscriptionpolicy
        }, fields);
}

isolated function queryOneSubscriptions(anydata key) returns record {}|persist:NotFoundError {
    table<Subscription> key(subscriptionId) subscriptionsClonedTable;
    lock {
        subscriptionsClonedTable = subscriptionsTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    table<Organization> key(orgId) organizationsClonedTable;
    lock {
        organizationsClonedTable = organizationsTable.clone();
    }
    table<ThrottlingPolicy> key(policyId) throttlingpoliciesClonedTable;
    lock {
        throttlingpoliciesClonedTable = throttlingpoliciesTable.clone();
    }
    from record {} 'object in subscriptionsClonedTable
    where persist:getKey('object, ["subscriptionId"]) == key
    outer join var api in apimetadataClonedTable on ['object.apiApiId] equals [api?.apiId]
    outer join var user in usersClonedTable on ['object.userUserId] equals [user?.userId]
    outer join var organization in organizationsClonedTable on ['object.organizationOrgId] equals [organization?.orgId]
    outer join var subscriptionpolicy in throttlingpoliciesClonedTable on ['object.subscriptionPolicyId] equals [subscriptionpolicy?.policyId]
    do {
        return {
            ...'object,
            "api": api,
            "user": user,
            "organization": organization,
            "subscriptionPolicy": subscriptionpolicy
        };
    };
    return persist:getNotFoundError("Subscription", key);
}

isolated function queryApiMetadataAdditionalproperties(record {} value, string[] fields) returns record {}[] {
    table<AdditionalProperties> key(propertyId) additionalpropertiesClonedTable;
    lock {
        additionalpropertiesClonedTable = additionalpropertiesTable.clone();
    }
    return from record {} 'object in additionalpropertiesClonedTable
        where 'object.apimetadataApiId == value["apiId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryApiMetadataThrottlingpolicies(record {} value, string[] fields) returns record {}[] {
    table<ThrottlingPolicy> key(policyId) throttlingpoliciesClonedTable;
    lock {
        throttlingpoliciesClonedTable = throttlingpoliciesTable.clone();
    }
    return from record {} 'object in throttlingpoliciesClonedTable
        where 'object.apimetadataApiId == value["apiId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryApiMetadataReviews(record {} value, string[] fields) returns record {}[] {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    return from record {} 'object in reviewsClonedTable
        where 'object.apifeedbackApiId == value["apiId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryApiMetadataSubscriptions(record {} value, string[] fields) returns record {}[] {
    table<Subscription> key(subscriptionId) subscriptionsClonedTable;
    lock {
        subscriptionsClonedTable = subscriptionsTable.clone();
    }
    return from record {} 'object in subscriptionsClonedTable
        where 'object.apiApiId == value["apiId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryApplicationAppproperties(record {} value, string[] fields) returns record {}[] {
    table<ApplicationProperties> key(propertyId) applicationpropertiesClonedTable;
    lock {
        applicationpropertiesClonedTable = applicationpropertiesTable.clone();
    }
    return from record {} 'object in applicationpropertiesClonedTable
        where 'object.applicationAppId == value["appId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryApplicationAccesscontrol(record {} value, string[] fields) returns record {}[] {
    table<User> key(userId) usersClonedTable;
    lock {
        usersClonedTable = usersTable.clone();
    }
    return from record {} 'object in usersClonedTable
        where 'object.applicationAppId == value["appId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOrganizationTheme(record {} value, string[] fields) returns record {}[] {
    table<Theme> key(themeId) themesClonedTable;
    lock {
        themesClonedTable = themesTable.clone();
    }
    return from record {} 'object in themesClonedTable
        where 'object.organizationOrgId == value["orgId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOrganizationIdentityprovider(record {} value, string[] fields) returns record {}[] {
    table<IdentityProvider> key(idpID) identityprovidersClonedTable;
    lock {
        identityprovidersClonedTable = identityprovidersTable.clone();
    }
    return from record {} 'object in identityprovidersClonedTable
        where 'object.organizationOrgId == value["orgId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOrganizationSubscriptions(record {} value, string[] fields) returns record {}[] {
    table<Subscription> key(subscriptionId) subscriptionsClonedTable;
    lock {
        subscriptionsClonedTable = subscriptionsTable.clone();
    }
    return from record {} 'object in subscriptionsClonedTable
        where 'object.organizationOrgId == value["orgId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryUserReviews(record {} value, string[] fields) returns record {}[] {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    return from record {} 'object in reviewsClonedTable
        where 'object.reviewedbyUserId == value["userId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryUserSubscriptions(record {} value, string[] fields) returns record {}[] {
    table<Subscription> key(subscriptionId) subscriptionsClonedTable;
    lock {
        subscriptionsClonedTable = subscriptionsTable.clone();
    }
    return from record {} 'object in subscriptionsClonedTable
        where 'object.userUserId == value["userId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

