// import devportal.models;
// import devportal.store;

// import ballerina/graphql;

// final store:Client sClient = check new ();

// service /apiUserPortal on new graphql:Listener(4000) {

//     # Retrieve the details for an API.
//     #
//     # + apiID - parameter description
//     # + return - return value description
//     resource function get apiMetaData(string apiID) returns models:ApiMetadata {

//         //stream<store:ApiMetadata, persist:Error?> employees = sClient->/apiMetaData;

//         // models:ApiMetadata? apiContent = sClient->/store:ApiMetadata;

//         models:ApiMetadata api = {
//             serverUrl: {sandboxUrl: "", productionUrl: ""},
//             throttlingPolicies: (),
//             apiInfo: {apiName: "", apiCategory: [], apiImage: "", openApiDefinition: "", additionalProperties: {}}
//         };

//         return api;
//     }

//     # Filter the APIs using category or a keyword/s.
//     #
//     # + orgId - parameter description  
//     # + category - parameter description
//     # + return - return value description
//     resource function get apifilter(string orgId, string category, string? keywords) returns models:ApiMetadata[] {

//         // stream<store:ApiMetadata, persist:Error?> apiContent = sClient->/apimetadata/[orgId];

//         // models:ApiMetadata[] apiDetails = from var apiData in entry:apiMetadataTable
//         //     where apiData.orgId == orgId
//         //     select apiData;
//         // models:ApiMetadata[] filteredData = [];
//         // foreach var api in apiDetails {

//         //     foreach var item in api.apiInfo.apiCategory {
//         //         if (category.equalsIgnoreCaseAscii(item)) {
//         //             filteredData.push(api);
//         //         }
//         //     }
//         // }
//         models:ApiMetadata[] metaData = [
//             {
//                 serverUrl: {sandboxUrl: "", productionUrl: ""},
//                 throttlingPolicies: (),
//                 apiInfo: {
//                     apiName: "",
//                     apiCategory: [],
//                     apiImage: "",
//                     openApiDefinition: "",
//                     additionalProperties: {}
//                 }
//             }
//         ];

//         return metaData;
//     }

//     # Create an application.
//     #
//     # + application - parameter description
//     # + return - return value description
//     remote function addApplicationDetails(models:Application application) returns models:ApplicationResponse {

//         // entry:applicationDetails.add(application);
//         // return new (application);
//         return new (application);
//     }

//     # Retrieve application details.
//     #
//     # + appId - parameter description
//     # + return - return value description
//     resource function get applications(string appId) returns models:ApplicationResponse {

//         // models:Application? application = entry:applicationDetails[appId];
//         // if application is models:Application {
//         //     return new (application);
//         // }
//         // return;

//         models:Application app = {accessControl: [], addedAPIs: [], appId: "", applicationName: "", appProperties: []};
//         return new (app);
//     }

//     # Add consumer specific details.
//     # + consumerComponentDetails - details related to the component and consumer
//     # + return - return value description
//     remote function consumerComponentDetails(models:ConsumerComponentDetails consumerComponentDetails) returns models:ConsuemrComponentDetailsResponse {

//         // entry:organizationDetails.add(consumerComponentDetails);
//         // return new (consumerComponentDetails);
//         models:ConsumerComponentDetails userComponentDetails = {
//             comment: {APIId: "", comment: "", rating: 0},
//             subscribedAPIs: [],
//             userId: "",
//             orgId: ""
//         };
//         return new (userComponentDetails);
//     }

//     # Retrieve consumer specific component details.
//     #
//     # + orgId - parameter description
//     # + return - return value description
//     resource function get consumerComponentDetails(string orgId) returns models:ConsuemrComponentDetailsResponse? {

//         // models:ConsumerComponentDetails? organization = entry:organizationDetails[orgId];
//         // if organization is models:ConsumerComponentDetails {
//         //     return new (organization);
//         // }
//         // return;
//         models:ConsumerComponentDetails userComponentDetails = {
//             comment: {APIId: "", comment: "", rating: 0},
//             subscribedAPIs: [],
//             userId: "",
//             orgId: ""
//         };
//         return new (userComponentDetails);
//     }

// }
