import devportal.content;
import devportal.theme;

import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /devPortal/admin on new http:Listener(8080) {

    resource function post theme(@http:Payload theme:ThemeEntry themeData) returns json {

        content:themeEntriesTable.add(themeData);
        table<theme:ThemeEntry> themeRecords = from var themeRecord in content:themeEntriesTable
            where themeRecord.themeId == themeData.themeId
            select themeRecord;
        return themeRecords.toJson();
    }
    resource function get theme(string themeId) returns json {

        table<theme:ThemeEntry> themeRecords = from var themeRecord in content:themeEntriesTable
            where themeRecord.themeId == themeId
            select themeRecord;
        return themeRecords.toJson();
    }

    # A resource for content changes of the organizatoion landing page
    # + return - string name with hello message or error
    resource function post organizationDetails(@http:Payload content:OrganizationContent organizationDetails) returns content:OrganizationContent|error {
        // Send a response back to the caller.
        return organizationDetails;
    }

    # A resource for content changes of the dev portal components landing page
    # + return - string name with hello message or error
    resource function post componentDetails(@http:Payload content:ComponentContent componentDefinition) returns content:ComponentContent|error {
        // Send a response back to the caller.
        return componentDefinition;
    }

}

