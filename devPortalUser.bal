import devportal.entry;
import devportal.models;

import ballerina/graphql;

service graphql:Service /devPortalContent on new graphql:Listener(4000) {

    resource function get componentContent(string orgId) returns models:ComponentContent? {

        models:ComponentContent? componentEntry = entry:componentDetails[orgId];
        if componentEntry is models:ComponentContent {
            return componentEntry;
        }
        return;
    }

    resource function get applications(string appId) returns models:Application? {
        models:Application? application = entry:applicationDetails[appId];
        if application is models:Application {
            return application;
        }
        return;
    }


    resource function get organizations(string orgId) returns models:Organization? {

        models:Organization? organization = entry:organizationDetails[orgId];
        if organization is models:Organization {
            return organization;
        }
        return;
    }

}
