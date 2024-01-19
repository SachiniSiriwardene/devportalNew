import ballerina/graphql;
import devportal.models;
import devportal.entry;
service graphql:Service /devPortalContent on new graphql:Listener(4000) {

    resource function get organizations(string orgId) returns models:Organization? {

        models:Organization? organization = entry:organizationDetails[orgId];
        if organization is models:Organization {
            return organization;
        }
        return;
    }

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

    resource function get componentContent(string orgId) returns models:ComponentContent? {

        models:ComponentContent? componentEntry = entry:componentDetails[orgId];
        if componentEntry is models:ComponentContent {
            return componentEntry;
        }
        return;
    }

    remote function addApplicationDetails(models:Application application) returns models:ApplicationResponse {

        entry:applicationDetails.add(application);
        return new (application);
    }

    resource function get applications(string appId) returns models:ApplicationResponse? {
        models:Application? application = entry:applicationDetails[appId];
        if application is models:Application {
            return new (application);
        }
        return;
    }

}
