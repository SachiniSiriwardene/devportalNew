// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/persist.sql as psql;

const THROTTLING_POLICY = "throttlingpolicies";
const RATE_LIMITING_POLICY = "ratelimitingpolicies";
const REVIEW = "reviews";
const API_METADATA = "apimetadata";
const API_CONTENT = "apicontents";
const API_IMAGES = "apiimages";
const ADDITIONAL_PROPERTIES = "additionalproperties";
const IDENTITY_PROVIDER = "identityproviders";
const THEME = "themes";
const APPLICATION = "applications";
const ORGANIZATION = "organizations";
const ORGANIZATION_ASSETS = "organizationassets";
const APPLICATION_PROPERTIES = "applicationproperties";
const USER = "users";
const SUBSCRIPTION = "subscriptions";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [THROTTLING_POLICY] : {
            entityName: "ThrottlingPolicy",
            tableName: "ThrottlingPolicy",
            fieldMetadata: {
                policyId: {columnName: "policyId"},
                'type: {columnName: "type"},
                policyName: {columnName: "policyName"},
                description: {columnName: "description"},
                apimetadataApiId: {columnName: "apimetadataApiId"},
                apimetadataOrganizationName: {columnName: "apimetadataOrganizationName"},
                "apimetadata.apiId": {relation: {entityName: "apimetadata", refField: "apiId"}},
                "apimetadata.orgId": {relation: {entityName: "apimetadata", refField: "orgId"}},
                "apimetadata.apiName": {relation: {entityName: "apimetadata", refField: "apiName"}},
                "apimetadata.organizationName": {relation: {entityName: "apimetadata", refField: "organizationName"}},
                "apimetadata.apiCategory": {relation: {entityName: "apimetadata", refField: "apiCategory"}},
                "apimetadata.openApiDefinition": {relation: {entityName: "apimetadata", refField: "openApiDefinition"}},
                "apimetadata.productionUrl": {relation: {entityName: "apimetadata", refField: "productionUrl"}},
                "apimetadata.sandboxUrl": {relation: {entityName: "apimetadata", refField: "sandboxUrl"}},
                "subscription.subscriptionId": {relation: {entityName: "subscription", refField: "subscriptionId"}},
                "subscription.apiApiId": {relation: {entityName: "subscription", refField: "apiApiId"}},
                "subscription.apiOrganizationName": {relation: {entityName: "subscription", refField: "apiOrganizationName"}},
                "subscription.userUserId": {relation: {entityName: "subscription", refField: "userUserId"}},
                "subscription.organizationOrgId": {relation: {entityName: "subscription", refField: "organizationOrgId"}},
                "subscription.subscriptionPolicyId": {relation: {entityName: "subscription", refField: "subscriptionPolicyId"}}
            },
            keyFields: ["policyId"],
            joinMetadata: {
                apimetadata: {entity: ApiMetadata, fieldName: "apimetadata", refTable: "ApiMetadata", refColumns: ["apiId", "organizationName"], joinColumns: ["apimetadataApiId", "apimetadataOrganizationName"], 'type: psql:ONE_TO_MANY},
                subscription: {entity: Subscription, fieldName: "subscription", refTable: "Subscription", refColumns: ["subscriptionPolicyId"], joinColumns: ["policyId"], 'type: psql:ONE_TO_ONE}
            }
        },
        [RATE_LIMITING_POLICY] : {
            entityName: "RateLimitingPolicy",
            tableName: "RateLimitingPolicy",
            fieldMetadata: {
                policyId: {columnName: "policyId"},
                policyName: {columnName: "policyName"},
                policyInfo: {columnName: "policyInfo"}
            },
            keyFields: ["policyId"]
        },
        [REVIEW] : {
            entityName: "Review",
            tableName: "Review",
            fieldMetadata: {
                reviewId: {columnName: "reviewId"},
                rating: {columnName: "rating"},
                comment: {columnName: "comment"},
                apifeedbackApiId: {columnName: "apifeedbackApiId"},
                apifeedbackOrganizationName: {columnName: "apifeedbackOrganizationName"},
                reviewedbyUserId: {columnName: "reviewedbyUserId"},
                "apiFeedback.apiId": {relation: {entityName: "apiFeedback", refField: "apiId"}},
                "apiFeedback.orgId": {relation: {entityName: "apiFeedback", refField: "orgId"}},
                "apiFeedback.apiName": {relation: {entityName: "apiFeedback", refField: "apiName"}},
                "apiFeedback.organizationName": {relation: {entityName: "apiFeedback", refField: "organizationName"}},
                "apiFeedback.apiCategory": {relation: {entityName: "apiFeedback", refField: "apiCategory"}},
                "apiFeedback.openApiDefinition": {relation: {entityName: "apiFeedback", refField: "openApiDefinition"}},
                "apiFeedback.productionUrl": {relation: {entityName: "apiFeedback", refField: "productionUrl"}},
                "apiFeedback.sandboxUrl": {relation: {entityName: "apiFeedback", refField: "sandboxUrl"}},
                "reviewedBy.userId": {relation: {entityName: "reviewedBy", refField: "userId"}},
                "reviewedBy.role": {relation: {entityName: "reviewedBy", refField: "role"}},
                "reviewedBy.userName": {relation: {entityName: "reviewedBy", refField: "userName"}},
                "reviewedBy.applicationAppId": {relation: {entityName: "reviewedBy", refField: "applicationAppId"}}
            },
            keyFields: ["reviewId"],
            joinMetadata: {
                apiFeedback: {entity: ApiMetadata, fieldName: "apiFeedback", refTable: "ApiMetadata", refColumns: ["apiId", "organizationName"], joinColumns: ["apifeedbackApiId", "apifeedbackOrganizationName"], 'type: psql:ONE_TO_MANY},
                reviewedBy: {entity: User, fieldName: "reviewedBy", refTable: "User", refColumns: ["userId"], joinColumns: ["reviewedbyUserId"], 'type: psql:ONE_TO_MANY}
            }
        },
        [API_METADATA] : {
            entityName: "ApiMetadata",
            tableName: "ApiMetadata",
            fieldMetadata: {
                apiId: {columnName: "apiId"},
                orgId: {columnName: "orgId"},
                apiName: {columnName: "apiName"},
                organizationName: {columnName: "organizationName"},
                apiCategory: {columnName: "apiCategory"},
                openApiDefinition: {columnName: "openApiDefinition"},
                productionUrl: {columnName: "productionUrl"},
                sandboxUrl: {columnName: "sandboxUrl"},
                "additionalProperties[].propertyId": {relation: {entityName: "additionalProperties", refField: "propertyId"}},
                "additionalProperties[].key": {relation: {entityName: "additionalProperties", refField: "key"}},
                "additionalProperties[].value": {relation: {entityName: "additionalProperties", refField: "value"}},
                "additionalProperties[].apimetadataApiId": {relation: {entityName: "additionalProperties", refField: "apimetadataApiId"}},
                "additionalProperties[].apimetadataOrganizationName": {relation: {entityName: "additionalProperties", refField: "apimetadataOrganizationName"}},
                "throttlingPolicies[].policyId": {relation: {entityName: "throttlingPolicies", refField: "policyId"}},
                "throttlingPolicies[].type": {relation: {entityName: "throttlingPolicies", refField: "type"}},
                "throttlingPolicies[].policyName": {relation: {entityName: "throttlingPolicies", refField: "policyName"}},
                "throttlingPolicies[].description": {relation: {entityName: "throttlingPolicies", refField: "description"}},
                "throttlingPolicies[].apimetadataApiId": {relation: {entityName: "throttlingPolicies", refField: "apimetadataApiId"}},
                "throttlingPolicies[].apimetadataOrganizationName": {relation: {entityName: "throttlingPolicies", refField: "apimetadataOrganizationName"}},
                "reviews[].reviewId": {relation: {entityName: "reviews", refField: "reviewId"}},
                "reviews[].rating": {relation: {entityName: "reviews", refField: "rating"}},
                "reviews[].comment": {relation: {entityName: "reviews", refField: "comment"}},
                "reviews[].apifeedbackApiId": {relation: {entityName: "reviews", refField: "apifeedbackApiId"}},
                "reviews[].apifeedbackOrganizationName": {relation: {entityName: "reviews", refField: "apifeedbackOrganizationName"}},
                "reviews[].reviewedbyUserId": {relation: {entityName: "reviews", refField: "reviewedbyUserId"}},
                "subscriptions[].subscriptionId": {relation: {entityName: "subscriptions", refField: "subscriptionId"}},
                "subscriptions[].apiApiId": {relation: {entityName: "subscriptions", refField: "apiApiId"}},
                "subscriptions[].apiOrganizationName": {relation: {entityName: "subscriptions", refField: "apiOrganizationName"}},
                "subscriptions[].userUserId": {relation: {entityName: "subscriptions", refField: "userUserId"}},
                "subscriptions[].organizationOrgId": {relation: {entityName: "subscriptions", refField: "organizationOrgId"}},
                "subscriptions[].subscriptionPolicyId": {relation: {entityName: "subscriptions", refField: "subscriptionPolicyId"}},
                "apiContent[].contentId": {relation: {entityName: "apiContent", refField: "contentId"}},
                "apiContent[].apiContent": {relation: {entityName: "apiContent", refField: "apiContent"}},
                "apiContent[].apimetadataApiId": {relation: {entityName: "apiContent", refField: "apimetadataApiId"}},
                "apiContent[].apimetadataOrganizationName": {relation: {entityName: "apiContent", refField: "apimetadataOrganizationName"}},
                "apiImages[].imageId": {relation: {entityName: "apiImages", refField: "imageId"}},
                "apiImages[].key": {relation: {entityName: "apiImages", refField: "key"}},
                "apiImages[].value": {relation: {entityName: "apiImages", refField: "value"}},
                "apiImages[].apimetadataApiId": {relation: {entityName: "apiImages", refField: "apimetadataApiId"}},
                "apiImages[].apimetadataOrganizationName": {relation: {entityName: "apiImages", refField: "apimetadataOrganizationName"}}
            },
            keyFields: ["apiId", "organizationName"],
            joinMetadata: {
                additionalProperties: {entity: AdditionalProperties, fieldName: "additionalProperties", refTable: "AdditionalProperties", refColumns: ["apimetadataApiId", "apimetadataOrganizationName"], joinColumns: ["apiId", "organizationName"], 'type: psql:MANY_TO_ONE},
                throttlingPolicies: {entity: ThrottlingPolicy, fieldName: "throttlingPolicies", refTable: "ThrottlingPolicy", refColumns: ["apimetadataApiId", "apimetadataOrganizationName"], joinColumns: ["apiId", "organizationName"], 'type: psql:MANY_TO_ONE},
                reviews: {entity: Review, fieldName: "reviews", refTable: "Review", refColumns: ["apifeedbackApiId", "apifeedbackOrganizationName"], joinColumns: ["apiId", "organizationName"], 'type: psql:MANY_TO_ONE},
                subscriptions: {entity: Subscription, fieldName: "subscriptions", refTable: "Subscription", refColumns: ["apiApiId", "apiOrganizationName"], joinColumns: ["apiId", "organizationName"], 'type: psql:MANY_TO_ONE},
                apiContent: {entity: ApiContent, fieldName: "apiContent", refTable: "ApiContent", refColumns: ["apimetadataApiId", "apimetadataOrganizationName"], joinColumns: ["apiId", "organizationName"], 'type: psql:MANY_TO_ONE},
                apiImages: {entity: ApiImages, fieldName: "apiImages", refTable: "ApiImages", refColumns: ["apimetadataApiId", "apimetadataOrganizationName"], joinColumns: ["apiId", "organizationName"], 'type: psql:MANY_TO_ONE}
            }
        },
        [API_CONTENT] : {
            entityName: "ApiContent",
            tableName: "ApiContent",
            fieldMetadata: {
                contentId: {columnName: "contentId"},
                apiContent: {columnName: "apiContent"},
                apimetadataApiId: {columnName: "apimetadataApiId"},
                apimetadataOrganizationName: {columnName: "apimetadataOrganizationName"},
                "apimetadata.apiId": {relation: {entityName: "apimetadata", refField: "apiId"}},
                "apimetadata.orgId": {relation: {entityName: "apimetadata", refField: "orgId"}},
                "apimetadata.apiName": {relation: {entityName: "apimetadata", refField: "apiName"}},
                "apimetadata.organizationName": {relation: {entityName: "apimetadata", refField: "organizationName"}},
                "apimetadata.apiCategory": {relation: {entityName: "apimetadata", refField: "apiCategory"}},
                "apimetadata.openApiDefinition": {relation: {entityName: "apimetadata", refField: "openApiDefinition"}},
                "apimetadata.productionUrl": {relation: {entityName: "apimetadata", refField: "productionUrl"}},
                "apimetadata.sandboxUrl": {relation: {entityName: "apimetadata", refField: "sandboxUrl"}}
            },
            keyFields: ["contentId"],
            joinMetadata: {apimetadata: {entity: ApiMetadata, fieldName: "apimetadata", refTable: "ApiMetadata", refColumns: ["apiId", "organizationName"], joinColumns: ["apimetadataApiId", "apimetadataOrganizationName"], 'type: psql:ONE_TO_MANY}}
        },
        [API_IMAGES] : {
            entityName: "ApiImages",
            tableName: "ApiImages",
            fieldMetadata: {
                imageId: {columnName: "imageId"},
                key: {columnName: "key"},
                value: {columnName: "value"},
                apimetadataApiId: {columnName: "apimetadataApiId"},
                apimetadataOrganizationName: {columnName: "apimetadataOrganizationName"},
                "apimetadata.apiId": {relation: {entityName: "apimetadata", refField: "apiId"}},
                "apimetadata.orgId": {relation: {entityName: "apimetadata", refField: "orgId"}},
                "apimetadata.apiName": {relation: {entityName: "apimetadata", refField: "apiName"}},
                "apimetadata.organizationName": {relation: {entityName: "apimetadata", refField: "organizationName"}},
                "apimetadata.apiCategory": {relation: {entityName: "apimetadata", refField: "apiCategory"}},
                "apimetadata.openApiDefinition": {relation: {entityName: "apimetadata", refField: "openApiDefinition"}},
                "apimetadata.productionUrl": {relation: {entityName: "apimetadata", refField: "productionUrl"}},
                "apimetadata.sandboxUrl": {relation: {entityName: "apimetadata", refField: "sandboxUrl"}}
            },
            keyFields: ["imageId"],
            joinMetadata: {apimetadata: {entity: ApiMetadata, fieldName: "apimetadata", refTable: "ApiMetadata", refColumns: ["apiId", "organizationName"], joinColumns: ["apimetadataApiId", "apimetadataOrganizationName"], 'type: psql:ONE_TO_MANY}}
        },
        [ADDITIONAL_PROPERTIES] : {
            entityName: "AdditionalProperties",
            tableName: "AdditionalProperties",
            fieldMetadata: {
                propertyId: {columnName: "propertyId"},
                key: {columnName: "key"},
                value: {columnName: "value"},
                apimetadataApiId: {columnName: "apimetadataApiId"},
                apimetadataOrganizationName: {columnName: "apimetadataOrganizationName"},
                "apimetadata.apiId": {relation: {entityName: "apimetadata", refField: "apiId"}},
                "apimetadata.orgId": {relation: {entityName: "apimetadata", refField: "orgId"}},
                "apimetadata.apiName": {relation: {entityName: "apimetadata", refField: "apiName"}},
                "apimetadata.organizationName": {relation: {entityName: "apimetadata", refField: "organizationName"}},
                "apimetadata.apiCategory": {relation: {entityName: "apimetadata", refField: "apiCategory"}},
                "apimetadata.openApiDefinition": {relation: {entityName: "apimetadata", refField: "openApiDefinition"}},
                "apimetadata.productionUrl": {relation: {entityName: "apimetadata", refField: "productionUrl"}},
                "apimetadata.sandboxUrl": {relation: {entityName: "apimetadata", refField: "sandboxUrl"}}
            },
            keyFields: ["propertyId"],
            joinMetadata: {apimetadata: {entity: ApiMetadata, fieldName: "apimetadata", refTable: "ApiMetadata", refColumns: ["apiId", "organizationName"], joinColumns: ["apimetadataApiId", "apimetadataOrganizationName"], 'type: psql:ONE_TO_MANY}}
        },
        [IDENTITY_PROVIDER] : {
            entityName: "IdentityProvider",
            tableName: "IdentityProvider",
            fieldMetadata: {
                idpID: {columnName: "idpID"},
                name: {columnName: "name"},
                wellKnownEndpoint: {columnName: "wellKnownEndpoint"},
                introspectionEndpoint: {columnName: "introspectionEndpoint"},
                issuer: {columnName: "issuer"},
                jwksEndpoint: {columnName: "jwksEndpoint"},
                authorizeEndpoint: {columnName: "authorizeEndpoint"},
                envrionments: {columnName: "envrionments"},
                organizationOrgId: {columnName: "organizationOrgId"},
                "organization.orgId": {relation: {entityName: "organization", refField: "orgId"}},
                "organization.organizationName": {relation: {entityName: "organization", refField: "organizationName"}},
                "organization.templateName": {relation: {entityName: "organization", refField: "templateName"}},
                "organization.isDefault": {relation: {entityName: "organization", refField: "isDefault"}}
            },
            keyFields: ["idpID"],
            joinMetadata: {organization: {entity: Organization, fieldName: "organization", refTable: "Organization", refColumns: ["orgId"], joinColumns: ["organizationOrgId"], 'type: psql:ONE_TO_MANY}}
        },
        [THEME] : {
            entityName: "Theme",
            tableName: "Theme",
            fieldMetadata: {
                themeId: {columnName: "themeId"},
                organizationOrgId: {columnName: "organizationOrgId"},
                theme: {columnName: "theme"},
                "organization.orgId": {relation: {entityName: "organization", refField: "orgId"}},
                "organization.organizationName": {relation: {entityName: "organization", refField: "organizationName"}},
                "organization.templateName": {relation: {entityName: "organization", refField: "templateName"}},
                "organization.isDefault": {relation: {entityName: "organization", refField: "isDefault"}}
            },
            keyFields: ["themeId"],
            joinMetadata: {organization: {entity: Organization, fieldName: "organization", refTable: "Organization", refColumns: ["orgId"], joinColumns: ["organizationOrgId"], 'type: psql:ONE_TO_MANY}}
        },
        [APPLICATION] : {
            entityName: "Application",
            tableName: "Application",
            fieldMetadata: {
                appId: {columnName: "appId"},
                applicationName: {columnName: "applicationName"},
                sandBoxKey: {columnName: "sandBoxKey"},
                productionKey: {columnName: "productionKey"},
                addedAPIs: {columnName: "addedAPIs"},
                idpId: {columnName: "idpId"},
                "appProperties[].propertyId": {relation: {entityName: "appProperties", refField: "propertyId"}},
                "appProperties[].name": {relation: {entityName: "appProperties", refField: "name"}},
                "appProperties[].value": {relation: {entityName: "appProperties", refField: "value"}},
                "appProperties[].applicationAppId": {relation: {entityName: "appProperties", refField: "applicationAppId"}},
                "accessControl[].userId": {relation: {entityName: "accessControl", refField: "userId"}},
                "accessControl[].role": {relation: {entityName: "accessControl", refField: "role"}},
                "accessControl[].userName": {relation: {entityName: "accessControl", refField: "userName"}},
                "accessControl[].applicationAppId": {relation: {entityName: "accessControl", refField: "applicationAppId"}}
            },
            keyFields: ["appId"],
            joinMetadata: {
                appProperties: {entity: ApplicationProperties, fieldName: "appProperties", refTable: "ApplicationProperties", refColumns: ["applicationAppId"], joinColumns: ["appId"], 'type: psql:MANY_TO_ONE},
                accessControl: {entity: User, fieldName: "accessControl", refTable: "User", refColumns: ["applicationAppId"], joinColumns: ["appId"], 'type: psql:MANY_TO_ONE}
            }
        },
        [ORGANIZATION] : {
            entityName: "Organization",
            tableName: "Organization",
            fieldMetadata: {
                orgId: {columnName: "orgId"},
                organizationName: {columnName: "organizationName"},
                templateName: {columnName: "templateName"},
                isDefault: {columnName: "isDefault"},
                "organizationAssets.assetId": {relation: {entityName: "organizationAssets", refField: "assetId"}},
                "organizationAssets.orgAssets": {relation: {entityName: "organizationAssets", refField: "orgAssets"}},
                "organizationAssets.orgStyleSheet": {relation: {entityName: "organizationAssets", refField: "orgStyleSheet"}},
                "organizationAssets.apiStyleSheet": {relation: {entityName: "organizationAssets", refField: "apiStyleSheet"}},
                "organizationAssets.orgLandingPage": {relation: {entityName: "organizationAssets", refField: "orgLandingPage"}},
                "organizationAssets.apiLandingPage": {relation: {entityName: "organizationAssets", refField: "apiLandingPage"}},
                "organizationAssets.portalStyleSheet": {relation: {entityName: "organizationAssets", refField: "portalStyleSheet"}},
                "organizationAssets.organizationassetsOrgId": {relation: {entityName: "organizationAssets", refField: "organizationassetsOrgId"}},
                "theme[].themeId": {relation: {entityName: "theme", refField: "themeId"}},
                "theme[].organizationOrgId": {relation: {entityName: "theme", refField: "organizationOrgId"}},
                "theme[].theme": {relation: {entityName: "theme", refField: "theme"}},
                "identityProvider[].idpID": {relation: {entityName: "identityProvider", refField: "idpID"}},
                "identityProvider[].name": {relation: {entityName: "identityProvider", refField: "name"}},
                "identityProvider[].wellKnownEndpoint": {relation: {entityName: "identityProvider", refField: "wellKnownEndpoint"}},
                "identityProvider[].introspectionEndpoint": {relation: {entityName: "identityProvider", refField: "introspectionEndpoint"}},
                "identityProvider[].issuer": {relation: {entityName: "identityProvider", refField: "issuer"}},
                "identityProvider[].jwksEndpoint": {relation: {entityName: "identityProvider", refField: "jwksEndpoint"}},
                "identityProvider[].authorizeEndpoint": {relation: {entityName: "identityProvider", refField: "authorizeEndpoint"}},
                "identityProvider[].envrionments": {relation: {entityName: "identityProvider", refField: "envrionments"}},
                "identityProvider[].organizationOrgId": {relation: {entityName: "identityProvider", refField: "organizationOrgId"}},
                "subscriptions[].subscriptionId": {relation: {entityName: "subscriptions", refField: "subscriptionId"}},
                "subscriptions[].apiApiId": {relation: {entityName: "subscriptions", refField: "apiApiId"}},
                "subscriptions[].apiOrganizationName": {relation: {entityName: "subscriptions", refField: "apiOrganizationName"}},
                "subscriptions[].userUserId": {relation: {entityName: "subscriptions", refField: "userUserId"}},
                "subscriptions[].organizationOrgId": {relation: {entityName: "subscriptions", refField: "organizationOrgId"}},
                "subscriptions[].subscriptionPolicyId": {relation: {entityName: "subscriptions", refField: "subscriptionPolicyId"}}
            },
            keyFields: ["orgId"],
            joinMetadata: {
                organizationAssets: {entity: OrganizationAssets, fieldName: "organizationAssets", refTable: "OrganizationAssets", refColumns: ["organizationassetsOrgId"], joinColumns: ["orgId"], 'type: psql:ONE_TO_ONE},
                theme: {entity: Theme, fieldName: "theme", refTable: "Theme", refColumns: ["organizationOrgId"], joinColumns: ["orgId"], 'type: psql:MANY_TO_ONE},
                identityProvider: {entity: IdentityProvider, fieldName: "identityProvider", refTable: "IdentityProvider", refColumns: ["organizationOrgId"], joinColumns: ["orgId"], 'type: psql:MANY_TO_ONE},
                subscriptions: {entity: Subscription, fieldName: "subscriptions", refTable: "Subscription", refColumns: ["organizationOrgId"], joinColumns: ["orgId"], 'type: psql:MANY_TO_ONE}
            }
        },
        [ORGANIZATION_ASSETS] : {
            entityName: "OrganizationAssets",
            tableName: "OrganizationAssets",
            fieldMetadata: {
                assetId: {columnName: "assetId"},
                orgAssets: {columnName: "orgAssets"},
                orgStyleSheet: {columnName: "orgStyleSheet"},
                apiStyleSheet: {columnName: "apiStyleSheet"},
                orgLandingPage: {columnName: "orgLandingPage"},
                apiLandingPage: {columnName: "apiLandingPage"},
                portalStyleSheet: {columnName: "portalStyleSheet"},
                organizationassetsOrgId: {columnName: "organizationassetsOrgId"},
                "organization.orgId": {relation: {entityName: "organization", refField: "orgId"}},
                "organization.organizationName": {relation: {entityName: "organization", refField: "organizationName"}},
                "organization.templateName": {relation: {entityName: "organization", refField: "templateName"}},
                "organization.isDefault": {relation: {entityName: "organization", refField: "isDefault"}}
            },
            keyFields: ["assetId"],
            joinMetadata: {organization: {entity: Organization, fieldName: "organization", refTable: "Organization", refColumns: ["orgId"], joinColumns: ["organizationassetsOrgId"], 'type: psql:ONE_TO_ONE}}
        },
        [APPLICATION_PROPERTIES] : {
            entityName: "ApplicationProperties",
            tableName: "ApplicationProperties",
            fieldMetadata: {
                propertyId: {columnName: "propertyId"},
                name: {columnName: "name"},
                value: {columnName: "value"},
                applicationAppId: {columnName: "applicationAppId"},
                "application.appId": {relation: {entityName: "application", refField: "appId"}},
                "application.applicationName": {relation: {entityName: "application", refField: "applicationName"}},
                "application.sandBoxKey": {relation: {entityName: "application", refField: "sandBoxKey"}},
                "application.productionKey": {relation: {entityName: "application", refField: "productionKey"}},
                "application.addedAPIs": {relation: {entityName: "application", refField: "addedAPIs"}},
                "application.idpId": {relation: {entityName: "application", refField: "idpId"}}
            },
            keyFields: ["propertyId"],
            joinMetadata: {application: {entity: Application, fieldName: "application", refTable: "Application", refColumns: ["appId"], joinColumns: ["applicationAppId"], 'type: psql:ONE_TO_MANY}}
        },
        [USER] : {
            entityName: "User",
            tableName: "User",
            fieldMetadata: {
                userId: {columnName: "userId"},
                role: {columnName: "role"},
                userName: {columnName: "userName"},
                applicationAppId: {columnName: "applicationAppId"},
                "application.appId": {relation: {entityName: "application", refField: "appId"}},
                "application.applicationName": {relation: {entityName: "application", refField: "applicationName"}},
                "application.sandBoxKey": {relation: {entityName: "application", refField: "sandBoxKey"}},
                "application.productionKey": {relation: {entityName: "application", refField: "productionKey"}},
                "application.addedAPIs": {relation: {entityName: "application", refField: "addedAPIs"}},
                "application.idpId": {relation: {entityName: "application", refField: "idpId"}},
                "reviews[].reviewId": {relation: {entityName: "reviews", refField: "reviewId"}},
                "reviews[].rating": {relation: {entityName: "reviews", refField: "rating"}},
                "reviews[].comment": {relation: {entityName: "reviews", refField: "comment"}},
                "reviews[].apifeedbackApiId": {relation: {entityName: "reviews", refField: "apifeedbackApiId"}},
                "reviews[].apifeedbackOrganizationName": {relation: {entityName: "reviews", refField: "apifeedbackOrganizationName"}},
                "reviews[].reviewedbyUserId": {relation: {entityName: "reviews", refField: "reviewedbyUserId"}},
                "subscriptions[].subscriptionId": {relation: {entityName: "subscriptions", refField: "subscriptionId"}},
                "subscriptions[].apiApiId": {relation: {entityName: "subscriptions", refField: "apiApiId"}},
                "subscriptions[].apiOrganizationName": {relation: {entityName: "subscriptions", refField: "apiOrganizationName"}},
                "subscriptions[].userUserId": {relation: {entityName: "subscriptions", refField: "userUserId"}},
                "subscriptions[].organizationOrgId": {relation: {entityName: "subscriptions", refField: "organizationOrgId"}},
                "subscriptions[].subscriptionPolicyId": {relation: {entityName: "subscriptions", refField: "subscriptionPolicyId"}}
            },
            keyFields: ["userId"],
            joinMetadata: {
                application: {entity: Application, fieldName: "application", refTable: "Application", refColumns: ["appId"], joinColumns: ["applicationAppId"], 'type: psql:ONE_TO_MANY},
                reviews: {entity: Review, fieldName: "reviews", refTable: "Review", refColumns: ["reviewedbyUserId"], joinColumns: ["userId"], 'type: psql:MANY_TO_ONE},
                subscriptions: {entity: Subscription, fieldName: "subscriptions", refTable: "Subscription", refColumns: ["userUserId"], joinColumns: ["userId"], 'type: psql:MANY_TO_ONE}
            }
        },
        [SUBSCRIPTION] : {
            entityName: "Subscription",
            tableName: "Subscription",
            fieldMetadata: {
                subscriptionId: {columnName: "subscriptionId"},
                apiApiId: {columnName: "apiApiId"},
                apiOrganizationName: {columnName: "apiOrganizationName"},
                userUserId: {columnName: "userUserId"},
                organizationOrgId: {columnName: "organizationOrgId"},
                subscriptionPolicyId: {columnName: "subscriptionPolicyId"},
                "api.apiId": {relation: {entityName: "api", refField: "apiId"}},
                "api.orgId": {relation: {entityName: "api", refField: "orgId"}},
                "api.apiName": {relation: {entityName: "api", refField: "apiName"}},
                "api.organizationName": {relation: {entityName: "api", refField: "organizationName"}},
                "api.apiCategory": {relation: {entityName: "api", refField: "apiCategory"}},
                "api.openApiDefinition": {relation: {entityName: "api", refField: "openApiDefinition"}},
                "api.productionUrl": {relation: {entityName: "api", refField: "productionUrl"}},
                "api.sandboxUrl": {relation: {entityName: "api", refField: "sandboxUrl"}},
                "user.userId": {relation: {entityName: "user", refField: "userId"}},
                "user.role": {relation: {entityName: "user", refField: "role"}},
                "user.userName": {relation: {entityName: "user", refField: "userName"}},
                "user.applicationAppId": {relation: {entityName: "user", refField: "applicationAppId"}},
                "organization.orgId": {relation: {entityName: "organization", refField: "orgId"}},
                "organization.organizationName": {relation: {entityName: "organization", refField: "organizationName"}},
                "organization.templateName": {relation: {entityName: "organization", refField: "templateName"}},
                "organization.isDefault": {relation: {entityName: "organization", refField: "isDefault"}},
                "subscriptionPolicy.policyId": {relation: {entityName: "subscriptionPolicy", refField: "policyId"}},
                "subscriptionPolicy.type": {relation: {entityName: "subscriptionPolicy", refField: "type"}},
                "subscriptionPolicy.policyName": {relation: {entityName: "subscriptionPolicy", refField: "policyName"}},
                "subscriptionPolicy.description": {relation: {entityName: "subscriptionPolicy", refField: "description"}},
                "subscriptionPolicy.apimetadataApiId": {relation: {entityName: "subscriptionPolicy", refField: "apimetadataApiId"}},
                "subscriptionPolicy.apimetadataOrganizationName": {relation: {entityName: "subscriptionPolicy", refField: "apimetadataOrganizationName"}}
            },
            keyFields: ["subscriptionId"],
            joinMetadata: {
                api: {entity: ApiMetadata, fieldName: "api", refTable: "ApiMetadata", refColumns: ["apiId", "organizationName"], joinColumns: ["apiApiId", "apiOrganizationName"], 'type: psql:ONE_TO_MANY},
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["userId"], joinColumns: ["userUserId"], 'type: psql:ONE_TO_MANY},
                organization: {entity: Organization, fieldName: "organization", refTable: "Organization", refColumns: ["orgId"], joinColumns: ["organizationOrgId"], 'type: psql:ONE_TO_MANY},
                subscriptionPolicy: {entity: ThrottlingPolicy, fieldName: "subscriptionPolicy", refTable: "ThrottlingPolicy", refColumns: ["policyId"], joinColumns: ["subscriptionPolicyId"], 'type: psql:ONE_TO_ONE}
            }
        }
    };

    public isolated function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [THROTTLING_POLICY] : check new (dbClient, self.metadata.get(THROTTLING_POLICY), psql:MYSQL_SPECIFICS),
            [RATE_LIMITING_POLICY] : check new (dbClient, self.metadata.get(RATE_LIMITING_POLICY), psql:MYSQL_SPECIFICS),
            [REVIEW] : check new (dbClient, self.metadata.get(REVIEW), psql:MYSQL_SPECIFICS),
            [API_METADATA] : check new (dbClient, self.metadata.get(API_METADATA), psql:MYSQL_SPECIFICS),
            [API_CONTENT] : check new (dbClient, self.metadata.get(API_CONTENT), psql:MYSQL_SPECIFICS),
            [API_IMAGES] : check new (dbClient, self.metadata.get(API_IMAGES), psql:MYSQL_SPECIFICS),
            [ADDITIONAL_PROPERTIES] : check new (dbClient, self.metadata.get(ADDITIONAL_PROPERTIES), psql:MYSQL_SPECIFICS),
            [IDENTITY_PROVIDER] : check new (dbClient, self.metadata.get(IDENTITY_PROVIDER), psql:MYSQL_SPECIFICS),
            [THEME] : check new (dbClient, self.metadata.get(THEME), psql:MYSQL_SPECIFICS),
            [APPLICATION] : check new (dbClient, self.metadata.get(APPLICATION), psql:MYSQL_SPECIFICS),
            [ORGANIZATION] : check new (dbClient, self.metadata.get(ORGANIZATION), psql:MYSQL_SPECIFICS),
            [ORGANIZATION_ASSETS] : check new (dbClient, self.metadata.get(ORGANIZATION_ASSETS), psql:MYSQL_SPECIFICS),
            [APPLICATION_PROPERTIES] : check new (dbClient, self.metadata.get(APPLICATION_PROPERTIES), psql:MYSQL_SPECIFICS),
            [USER] : check new (dbClient, self.metadata.get(USER), psql:MYSQL_SPECIFICS),
            [SUBSCRIPTION] : check new (dbClient, self.metadata.get(SUBSCRIPTION), psql:MYSQL_SPECIFICS)
        };
    }

    isolated resource function get throttlingpolicies(ThrottlingPolicyTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get throttlingpolicies/[string policyId](ThrottlingPolicyTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post throttlingpolicies(ThrottlingPolicyInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(THROTTLING_POLICY);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ThrottlingPolicyInsert inserted in data
            select inserted.policyId;
    }

    isolated resource function put throttlingpolicies/[string policyId](ThrottlingPolicyUpdate value) returns ThrottlingPolicy|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(THROTTLING_POLICY);
        }
        _ = check sqlClient.runUpdateQuery(policyId, value);
        return self->/throttlingpolicies/[policyId].get();
    }

    isolated resource function delete throttlingpolicies/[string policyId]() returns ThrottlingPolicy|persist:Error {
        ThrottlingPolicy result = check self->/throttlingpolicies/[policyId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(THROTTLING_POLICY);
        }
        _ = check sqlClient.runDeleteQuery(policyId);
        return result;
    }

    isolated resource function get ratelimitingpolicies(RateLimitingPolicyTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get ratelimitingpolicies/[string policyId](RateLimitingPolicyTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post ratelimitingpolicies(RateLimitingPolicyInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(RATE_LIMITING_POLICY);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from RateLimitingPolicyInsert inserted in data
            select inserted.policyId;
    }

    isolated resource function put ratelimitingpolicies/[string policyId](RateLimitingPolicyUpdate value) returns RateLimitingPolicy|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(RATE_LIMITING_POLICY);
        }
        _ = check sqlClient.runUpdateQuery(policyId, value);
        return self->/ratelimitingpolicies/[policyId].get();
    }

    isolated resource function delete ratelimitingpolicies/[string policyId]() returns RateLimitingPolicy|persist:Error {
        RateLimitingPolicy result = check self->/ratelimitingpolicies/[policyId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(RATE_LIMITING_POLICY);
        }
        _ = check sqlClient.runDeleteQuery(policyId);
        return result;
    }

    isolated resource function get reviews(ReviewTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get reviews/[string reviewId](ReviewTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post reviews(ReviewInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(REVIEW);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ReviewInsert inserted in data
            select inserted.reviewId;
    }

    isolated resource function put reviews/[string reviewId](ReviewUpdate value) returns Review|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(REVIEW);
        }
        _ = check sqlClient.runUpdateQuery(reviewId, value);
        return self->/reviews/[reviewId].get();
    }

    isolated resource function delete reviews/[string reviewId]() returns Review|persist:Error {
        Review result = check self->/reviews/[reviewId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(REVIEW);
        }
        _ = check sqlClient.runDeleteQuery(reviewId);
        return result;
    }

    isolated resource function get apimetadata(ApiMetadataTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get apimetadata/[string apiId]/[string organizationName](ApiMetadataTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post apimetadata(ApiMetadataInsert[] data) returns [string, string][]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_METADATA);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ApiMetadataInsert inserted in data
            select [inserted.apiId, inserted.organizationName];
    }

    isolated resource function put apimetadata/[string apiId]/[string organizationName](ApiMetadataUpdate value) returns ApiMetadata|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_METADATA);
        }
        _ = check sqlClient.runUpdateQuery({"apiId": apiId, "organizationName": organizationName}, value);
        return self->/apimetadata/[apiId]/[organizationName].get();
    }

    isolated resource function delete apimetadata/[string apiId]/[string organizationName]() returns ApiMetadata|persist:Error {
        ApiMetadata result = check self->/apimetadata/[apiId]/[organizationName].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_METADATA);
        }
        _ = check sqlClient.runDeleteQuery({"apiId": apiId, "organizationName": organizationName});
        return result;
    }

    isolated resource function get apicontents(ApiContentTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get apicontents/[string contentId](ApiContentTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post apicontents(ApiContentInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_CONTENT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ApiContentInsert inserted in data
            select inserted.contentId;
    }

    isolated resource function put apicontents/[string contentId](ApiContentUpdate value) returns ApiContent|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_CONTENT);
        }
        _ = check sqlClient.runUpdateQuery(contentId, value);
        return self->/apicontents/[contentId].get();
    }

    isolated resource function delete apicontents/[string contentId]() returns ApiContent|persist:Error {
        ApiContent result = check self->/apicontents/[contentId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_CONTENT);
        }
        _ = check sqlClient.runDeleteQuery(contentId);
        return result;
    }

    isolated resource function get apiimages(ApiImagesTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get apiimages/[string imageId](ApiImagesTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post apiimages(ApiImagesInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_IMAGES);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ApiImagesInsert inserted in data
            select inserted.imageId;
    }

    isolated resource function put apiimages/[string imageId](ApiImagesUpdate value) returns ApiImages|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_IMAGES);
        }
        _ = check sqlClient.runUpdateQuery(imageId, value);
        return self->/apiimages/[imageId].get();
    }

    isolated resource function delete apiimages/[string imageId]() returns ApiImages|persist:Error {
        ApiImages result = check self->/apiimages/[imageId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(API_IMAGES);
        }
        _ = check sqlClient.runDeleteQuery(imageId);
        return result;
    }

    isolated resource function get additionalproperties(AdditionalPropertiesTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get additionalproperties/[string propertyId](AdditionalPropertiesTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post additionalproperties(AdditionalPropertiesInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ADDITIONAL_PROPERTIES);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from AdditionalPropertiesInsert inserted in data
            select inserted.propertyId;
    }

    isolated resource function put additionalproperties/[string propertyId](AdditionalPropertiesUpdate value) returns AdditionalProperties|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ADDITIONAL_PROPERTIES);
        }
        _ = check sqlClient.runUpdateQuery(propertyId, value);
        return self->/additionalproperties/[propertyId].get();
    }

    isolated resource function delete additionalproperties/[string propertyId]() returns AdditionalProperties|persist:Error {
        AdditionalProperties result = check self->/additionalproperties/[propertyId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ADDITIONAL_PROPERTIES);
        }
        _ = check sqlClient.runDeleteQuery(propertyId);
        return result;
    }

    isolated resource function get identityproviders(IdentityProviderTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get identityproviders/[string idpID](IdentityProviderTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post identityproviders(IdentityProviderInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(IDENTITY_PROVIDER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from IdentityProviderInsert inserted in data
            select inserted.idpID;
    }

    isolated resource function put identityproviders/[string idpID](IdentityProviderUpdate value) returns IdentityProvider|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(IDENTITY_PROVIDER);
        }
        _ = check sqlClient.runUpdateQuery(idpID, value);
        return self->/identityproviders/[idpID].get();
    }

    isolated resource function delete identityproviders/[string idpID]() returns IdentityProvider|persist:Error {
        IdentityProvider result = check self->/identityproviders/[idpID].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(IDENTITY_PROVIDER);
        }
        _ = check sqlClient.runDeleteQuery(idpID);
        return result;
    }

    isolated resource function get themes(ThemeTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get themes/[string themeId](ThemeTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post themes(ThemeInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(THEME);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ThemeInsert inserted in data
            select inserted.themeId;
    }

    isolated resource function put themes/[string themeId](ThemeUpdate value) returns Theme|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(THEME);
        }
        _ = check sqlClient.runUpdateQuery(themeId, value);
        return self->/themes/[themeId].get();
    }

    isolated resource function delete themes/[string themeId]() returns Theme|persist:Error {
        Theme result = check self->/themes/[themeId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(THEME);
        }
        _ = check sqlClient.runDeleteQuery(themeId);
        return result;
    }

    isolated resource function get applications(ApplicationTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get applications/[string appId](ApplicationTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post applications(ApplicationInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPLICATION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ApplicationInsert inserted in data
            select inserted.appId;
    }

    isolated resource function put applications/[string appId](ApplicationUpdate value) returns Application|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPLICATION);
        }
        _ = check sqlClient.runUpdateQuery(appId, value);
        return self->/applications/[appId].get();
    }

    isolated resource function delete applications/[string appId]() returns Application|persist:Error {
        Application result = check self->/applications/[appId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPLICATION);
        }
        _ = check sqlClient.runDeleteQuery(appId);
        return result;
    }

    isolated resource function get organizations(OrganizationTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get organizations/[string orgId](OrganizationTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post organizations(OrganizationInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORGANIZATION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from OrganizationInsert inserted in data
            select inserted.orgId;
    }

    isolated resource function put organizations/[string orgId](OrganizationUpdate value) returns Organization|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORGANIZATION);
        }
        _ = check sqlClient.runUpdateQuery(orgId, value);
        return self->/organizations/[orgId].get();
    }

    isolated resource function delete organizations/[string orgId]() returns Organization|persist:Error {
        Organization result = check self->/organizations/[orgId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORGANIZATION);
        }
        _ = check sqlClient.runDeleteQuery(orgId);
        return result;
    }

    isolated resource function get organizationassets(OrganizationAssetsTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get organizationassets/[string assetId](OrganizationAssetsTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post organizationassets(OrganizationAssetsInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORGANIZATION_ASSETS);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from OrganizationAssetsInsert inserted in data
            select inserted.assetId;
    }

    isolated resource function put organizationassets/[string assetId](OrganizationAssetsUpdate value) returns OrganizationAssets|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORGANIZATION_ASSETS);
        }
        _ = check sqlClient.runUpdateQuery(assetId, value);
        return self->/organizationassets/[assetId].get();
    }

    isolated resource function delete organizationassets/[string assetId]() returns OrganizationAssets|persist:Error {
        OrganizationAssets result = check self->/organizationassets/[assetId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORGANIZATION_ASSETS);
        }
        _ = check sqlClient.runDeleteQuery(assetId);
        return result;
    }

    isolated resource function get applicationproperties(ApplicationPropertiesTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get applicationproperties/[string propertyId](ApplicationPropertiesTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post applicationproperties(ApplicationPropertiesInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPLICATION_PROPERTIES);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ApplicationPropertiesInsert inserted in data
            select inserted.propertyId;
    }

    isolated resource function put applicationproperties/[string propertyId](ApplicationPropertiesUpdate value) returns ApplicationProperties|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPLICATION_PROPERTIES);
        }
        _ = check sqlClient.runUpdateQuery(propertyId, value);
        return self->/applicationproperties/[propertyId].get();
    }

    isolated resource function delete applicationproperties/[string propertyId]() returns ApplicationProperties|persist:Error {
        ApplicationProperties result = check self->/applicationproperties/[propertyId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPLICATION_PROPERTIES);
        }
        _ = check sqlClient.runDeleteQuery(propertyId);
        return result;
    }

    isolated resource function get users(UserTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get users/[string userId](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.userId;
    }

    isolated resource function put users/[string userId](UserUpdate value) returns User|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runUpdateQuery(userId, value);
        return self->/users/[userId].get();
    }

    isolated resource function delete users/[string userId]() returns User|persist:Error {
        User result = check self->/users/[userId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runDeleteQuery(userId);
        return result;
    }

    isolated resource function get subscriptions(SubscriptionTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get subscriptions/[string subscriptionId](SubscriptionTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post subscriptions(SubscriptionInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SUBSCRIPTION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from SubscriptionInsert inserted in data
            select inserted.subscriptionId;
    }

    isolated resource function put subscriptions/[string subscriptionId](SubscriptionUpdate value) returns Subscription|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SUBSCRIPTION);
        }
        _ = check sqlClient.runUpdateQuery(subscriptionId, value);
        return self->/subscriptions/[subscriptionId].get();
    }

    isolated resource function delete subscriptions/[string subscriptionId]() returns Subscription|persist:Error {
        Subscription result = check self->/subscriptions/[subscriptionId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SUBSCRIPTION);
        }
        _ = check sqlClient.runDeleteQuery(subscriptionId);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

