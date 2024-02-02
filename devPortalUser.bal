import devportal.models;
import devportal.store;

import ballerina/graphql;
import ballerina/persist;

final store:Client userClient = check new ();

service /apiUserPortal on new graphql:Listener(4000) {

    # Retrieve the details for an API.
    #
    # + apiID - parameter description
    # + return - return value description
    resource function get apiMetaData(string apiID) returns models:ApiMetadata {

        models:ApiMetadata api = {
            serverUrl: {sandboxUrl: "", productionUrl: ""},
            throttlingPolicies: (),
            apiInfo: {apiName: "", apiCategory: [], apiImage: "", openApiDefinition: "", additionalProperties: {}}
        };

        return api;
    }

    # Filter the APIs using category or a keyword/s.
    #
    # + orgId - parameter description  
    # + category - parameter description
    # + return - return value description
    resource function get apifilter(string orgId, string category, string? keywords) returns models:ApiMetadata[]|persist:Error {

        stream<store:ApiMetadataWithRelations, persist:Error?> apiData = userClient->/apimetadata.get();
        models:ApiMetadata[] filteredData = [];
        store:ApiMetadataWithRelations[] metaDataList = check from var apiMetadata in apiData
            select apiMetadata;

        foreach var api in metaDataList {
            foreach var item in api.apiCategory ?: [] {
                if (category.equalsIgnoreCaseAscii(item)) {

                    store:ThrottlingPolicyOptionalized[] policies = api.throttlingPolicies ?: [];
                    models:ThrottlingPolicy[] throttlingPolicies = [];
                    foreach var policy in policies {
                        models:ThrottlingPolicy policyData = {
                            policyName: policy.policyName ?: "",
                            description: policy.description ?: "",
                            'type: policy.'type ?: ""
                        };
                        throttlingPolicies.push(policyData);

                    }

                    store:AdditionalPropertiesOptionalized[] additionalProperties = api.additionalProperties ?: [];
                    map<string> properties = {};
                    foreach var property in additionalProperties {
                        properties[property.key ?: ""] = property.value ?: "";
                    }
                    models:ApiMetadata metaData = {
                        serverUrl:
                            {
                            sandboxUrl: api.sandboxUrl ?: "",
                            productionUrl: api.productionUrl ?: ""
                        },
                        throttlingPolicies: throttlingPolicies,
                        apiInfo: {
                            apiName: api.apiName ?: "",
                            apiCategory: api.apiCategory ?: [],
                            apiImage: api?.apiImage,
                            openApiDefinition: api.openApiDefinition ?: "",
                            additionalProperties: properties
                        }
                    };
                    filteredData.push(metaData);
                }
            }
        }
        return filteredData;
    }

    # Create an application.
    #
    # + application - parameter description
    # + return - return value description
    remote function addApplicationDetails(models:Application application) returns models:ApplicationResponse {

        // entry:applicationDetails.add(application);
        // return new (application);
        return new (application);
    }

    # Retrieve application details.
    #
    # + appId - parameter description
    # + return - return value description
    resource function get applications(string appId) returns models:ApplicationResponse {

        // models:Application? application = entry:applicationDetails[appId];
        // if application is models:Application {
        //     return new (application);
        // }
        // return;

        models:Application app = {accessControl: [], addedAPIs: [], appId: "", applicationName: "", appProperties: []};
        return new (app);
    }

    # Add consumer specific details.
    # + consumerComponentDetails - details related to the component and consumer
    # + return - return value description
    remote function consumerComponentDetails(models:ConsumerComponentDetails consumerComponentDetails) returns models:ConsuemrComponentDetailsResponse {

        // entry:organizationDetails.add(consumerComponentDetails);
        // return new (consumerComponentDetails);
        models:ConsumerComponentDetails userComponentDetails = {
            comment: {APIId: "", comment: "", rating: 0},
            subscribedAPIs: [],
            userId: "",
            orgId: ""
        };
        return new (userComponentDetails);
    }

    # Retrieve consumer specific component details.
    #
    # + orgId - parameter description
    # + return - return value description
    resource function get consumerComponentDetails(string orgId) returns models:ConsuemrComponentDetailsResponse? {

        // models:ConsumerComponentDetails? organization = entry:organizationDetails[orgId];
        // if organization is models:ConsumerComponentDetails {
        //     return new (organization);
        // }
        // return;
        models:ConsumerComponentDetails userComponentDetails = {
            comment: {APIId: "", comment: "", rating: 0},
            subscribedAPIs: [],
            userId: "",
            orgId: ""
        };
        return new (userComponentDetails);
    }

}
