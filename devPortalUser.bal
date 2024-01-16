import ballerina/graphql;
import devportal.content;

service graphql:Service /devPortalContent on new graphql:Listener(4000) {

    # Retrieve details to display on the organization landing page.
    #
    # + orgId - parameter description
    # + return - return value description
    resource function get organizationContent(string orgId) returns content:OrganizationContentResponse? {

        content:OrganizationContent? orgEntry = content:orgContentDetails[orgId];
        if orgEntry is content:OrganizationContent {
            return new (orgEntry);
        }
        return;

    }
    // remote function addOrganizationDetails(OrganizationContent orgLandiPageContent) returns Organization {

    //     orgDetails.add(orgLandiPageContent);
    //     return new (orgLandiPageContent);
    // }

    resource function get componentContent(string orgId) returns content:ComponentDetails? {

        content:ComponentContent? componentEntry = content:componentDetails[orgId];
        if componentEntry is content:ComponentContent {
            return new (componentEntry);
        }
        return;
    }

    // remote function addComponentDetails(ComponentContent componentContent) returns  ComponentDetails{

    //     componentDetails.add(componentContent);
    //     return new (componentContent);
    // }

    remote function addApplicationDetails(content:Application application) returns content:ApplicationResponse {

        content:applicationDetails.add(application);
        return new (application);
    }

    resource function get applications(string appId) returns content:ApplicationResponse? {
        content:Application? application = content:applicationDetails[appId];
        if application is content:Application {
            return new (application);
        }
        return;
    }

    # Add organization specific details.
    #
    # + organization - details related to the organization
    # + return - return value description
    remote function userDefinedComponentDetails(content:ConsumerComponentDetails organization) returns content:ConsuemrComponentDetailsResponse {

        content:organizationDetails.add(organization);
        return new (organization);
    }

    resource function get userDefinedComponentDetails(string orgId) returns content:ConsuemrComponentDetailsResponse? {
        
        content:ConsumerComponentDetails? organization = content:organizationDetails[orgId];
        if organization is content:ConsumerComponentDetails {
            return new (organization);
        }
        return;
    }

}
