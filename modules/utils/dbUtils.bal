// import devportal.store;

// import ballerina/persist;

// //final store:Client client = check new ();

// public function getOrgId(string orgName) returns string|error {
    
//     //stream<store:OrganizationWithRelations, persist:Error?> organizations = client->/organizations.get();

//         //retrieve the organization id
//         store:OrganizationWithRelations[] organization = check from var org in organizations
//             where org.organizationName == orgName
//             select org;

// }