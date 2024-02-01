// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.inmemory;

const THROTTLING_POLICY = "throttlingpolicies";
const RATE_LIMITING_POLICY = "ratelimitingpolicies";
const FEEDBACK = "feedbacks";
const REVIEW = "reviews";
const API_METADATA = "apimetadata";
const ADDITIONAL_PROPERTIES = "additionalproperties";
const IDENTITY_PROVIDER = "identityproviders";
const THEME = "themes";
final isolated table<ThrottlingPolicy> key(policyId) throttlingpoliciesTable = table [];
final isolated table<RateLimitingPolicy> key(policyId) ratelimitingpoliciesTable = table [];
final isolated table<Feedback> key(apiId) feedbacksTable = table [];
final isolated table<Review> key(reviewId) reviewsTable = table [];
final isolated table<ApiMetadata> key(apiId) apimetadataTable = table [];
final isolated table<AdditionalProperties> key(propertyId) additionalpropertiesTable = table [];
final isolated table<IdentityProvider> key(idpID) identityprovidersTable = table [];
final isolated table<Theme> key(themeId) themesTable = table [];

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
            [FEEDBACK] : {
                keyFields: ["apiId"],
                query: queryFeedbacks,
                queryOne: queryOneFeedbacks,
                associationsMethods: {"reviews": queryFeedbackReviews}
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
                    "throttlingPolicies": queryApiMetadataThrottlingpolicies
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
            }
        };
        self.persistClients = {
            [THROTTLING_POLICY] : check new (metadata.get(THROTTLING_POLICY).cloneReadOnly()),
            [RATE_LIMITING_POLICY] : check new (metadata.get(RATE_LIMITING_POLICY).cloneReadOnly()),
            [FEEDBACK] : check new (metadata.get(FEEDBACK).cloneReadOnly()),
            [REVIEW] : check new (metadata.get(REVIEW).cloneReadOnly()),
            [API_METADATA] : check new (metadata.get(API_METADATA).cloneReadOnly()),
            [ADDITIONAL_PROPERTIES] : check new (metadata.get(ADDITIONAL_PROPERTIES).cloneReadOnly()),
            [IDENTITY_PROVIDER] : check new (metadata.get(IDENTITY_PROVIDER).cloneReadOnly()),
            [THEME] : check new (metadata.get(THEME).cloneReadOnly())
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

    isolated resource function get feedbacks(FeedbackTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get feedbacks/[string apiId](FeedbackTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post feedbacks(FeedbackInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach FeedbackInsert value in data {
            lock {
                if feedbacksTable.hasKey(value.apiId) {
                    return persist:getAlreadyExistsError("Feedback", value.apiId);
                }
                feedbacksTable.put(value.clone());
            }
            keys.push(value.apiId);
        }
        return keys;
    }

    isolated resource function put feedbacks/[string apiId](FeedbackUpdate value) returns Feedback|persist:Error {
        lock {
            if !feedbacksTable.hasKey(apiId) {
                return persist:getNotFoundError("Feedback", apiId);
            }
            Feedback feedback = feedbacksTable.get(apiId);
            foreach var [k, v] in value.clone().entries() {
                feedback[k] = v;
            }
            feedbacksTable.put(feedback);
            return feedback.clone();
        }
    }

    isolated resource function delete feedbacks/[string apiId]() returns Feedback|persist:Error {
        lock {
            if !feedbacksTable.hasKey(apiId) {
                return persist:getNotFoundError("Feedback", apiId);
            }
            return feedbacksTable.remove(apiId).clone();
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

isolated function queryFeedbacks(string[] fields) returns stream<record {}, persist:Error?> {
    table<Feedback> key(apiId) feedbacksClonedTable;
    lock {
        feedbacksClonedTable = feedbacksTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    return from record {} 'object in feedbacksClonedTable
        outer join var apimetadata in apimetadataClonedTable on ['object.apimetadataApiId] equals [apimetadata?.apiId]
        select persist:filterRecord({
            ...'object,
            "apimetadata": apimetadata
        }, fields);
}

isolated function queryOneFeedbacks(anydata key) returns record {}|persist:NotFoundError {
    table<Feedback> key(apiId) feedbacksClonedTable;
    lock {
        feedbacksClonedTable = feedbacksTable.clone();
    }
    table<ApiMetadata> key(apiId) apimetadataClonedTable;
    lock {
        apimetadataClonedTable = apimetadataTable.clone();
    }
    from record {} 'object in feedbacksClonedTable
    where persist:getKey('object, ["apiId"]) == key
    outer join var apimetadata in apimetadataClonedTable on ['object.apimetadataApiId] equals [apimetadata?.apiId]
    do {
        return {
            ...'object,
            "apimetadata": apimetadata
        };
    };
    return persist:getNotFoundError("Feedback", key);
}

isolated function queryReviews(string[] fields) returns stream<record {}, persist:Error?> {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    table<Feedback> key(apiId) feedbacksClonedTable;
    lock {
        feedbacksClonedTable = feedbacksTable.clone();
    }
    return from record {} 'object in reviewsClonedTable
        outer join var feedback in feedbacksClonedTable on ['object.feedbackApiId] equals [feedback?.apiId]
        select persist:filterRecord({
            ...'object,
            "feedback": feedback
        }, fields);
}

isolated function queryOneReviews(anydata key) returns record {}|persist:NotFoundError {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    table<Feedback> key(apiId) feedbacksClonedTable;
    lock {
        feedbacksClonedTable = feedbacksTable.clone();
    }
    from record {} 'object in reviewsClonedTable
    where persist:getKey('object, ["reviewId"]) == key
    outer join var feedback in feedbacksClonedTable on ['object.feedbackApiId] equals [feedback?.apiId]
    do {
        return {
            ...'object,
            "feedback": feedback
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
    return from record {} 'object in identityprovidersClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneIdentityproviders(anydata key) returns record {}|persist:NotFoundError {
    table<IdentityProvider> key(idpID) identityprovidersClonedTable;
    lock {
        identityprovidersClonedTable = identityprovidersTable.clone();
    }
    from record {} 'object in identityprovidersClonedTable
    where persist:getKey('object, ["idpID"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("IdentityProvider", key);
}

isolated function queryThemes(string[] fields) returns stream<record {}, persist:Error?> {
    table<Theme> key(themeId) themesClonedTable;
    lock {
        themesClonedTable = themesTable.clone();
    }
    return from record {} 'object in themesClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneThemes(anydata key) returns record {}|persist:NotFoundError {
    table<Theme> key(themeId) themesClonedTable;
    lock {
        themesClonedTable = themesTable.clone();
    }
    from record {} 'object in themesClonedTable
    where persist:getKey('object, ["themeId"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Theme", key);
}

isolated function queryFeedbackReviews(record {} value, string[] fields) returns record {}[] {
    table<Review> key(reviewId) reviewsClonedTable;
    lock {
        reviewsClonedTable = reviewsTable.clone();
    }
    return from record {} 'object in reviewsClonedTable
        where 'object.feedbackApiId == value["apiId"]
        select persist:filterRecord({
            ...'object
        }, fields);
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

