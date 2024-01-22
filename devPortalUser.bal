import ballerina/graphql;
import devportal.models;
import devportal.entry;
service  /devPortalConsumer on new graphql:Listener(4000) {

    # Retrieve details to display on the organization landing page.
    #
    # + orgId - parameter description
    # + return - return value description
    resource function get organizationContent(string orgId) returns models:OrganizationContent? {

        models:OrganizationContent? orgEntry = entry:orgContentDetails[orgId];
        if orgEntry is models:OrganizationContent {
            return orgEntry;
        }
        return;

    }
    # Retrieve details to display on the component landing page.
    #
    # + orgId - parameter description
    # + return - return value description
    resource function get componentContent(string orgId) returns models:ComponentContent? {

        models:ComponentContent? componentEntry = entry:componentDetails[orgId];
        if componentEntry is models:ComponentContent {
            return componentEntry;
        }
        return;
    }

    resource function get apiContent(string apiID) returns models:ApiMetadata? {
        
      models:ApiMetadata? apiContent = entry:apiMetadataTable[apiID];
      if(apiContent is models:ApiMetadata) {
        return apiContent;
      }
        return ;
    }

    # Create an application.
    #
    # + application - parameter description
    # + return - return value description
    remote function addApplicationDetails(models:Application application) returns models:ApplicationResponse {

        entry:applicationDetails.add(application);
        return new (application);
    }

    # Retrieve application details.
    #
    # + appId - parameter description
    # + return - return value description
    resource function get applications(string appId) returns models:ApplicationResponse? {
        models:Application? application = entry:applicationDetails[appId];
        if application is models:Application {
            return new (application);
        }
        return;
    }

    # Add consumer specific details.
    # + consumerComponentDetails - details related to the component and consumer
    # + return - return value description
    remote function consumerComponentDetails(models:ConsumerComponentDetails consumerComponentDetails) returns models:ConsuemrComponentDetailsResponse {

        entry:organizationDetails.add(consumerComponentDetails);
        return new (consumerComponentDetails);
    }

    # Retrieve consumer specific component details.
    #
    # + orgId - parameter description
    # + return - return value description
    resource function get consumerComponentDetails(string orgId) returns models:ConsuemrComponentDetailsResponse? {
        
        models:ConsumerComponentDetails? organization = entry:organizationDetails[orgId];
        if organization is models:ConsumerComponentDetails {
            return new (organization);
        }
        return;
    }


}
