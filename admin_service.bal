import devportal.entry;
import devportal.models;

import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /devPortalAdmin on new http:Listener(8080) {

    resource function post admin/settings/[string organizationId](@http:Payload models:AdminSettings settingsEntry) returns models:AdminSettings {

        models:AdminSettings settingsResponse = {
            kind: settingsEntry.kind
        };
        if (settingsEntry.kind.equalsIgnoreCaseAscii("oraganizationPageContent")) {
            models:OrganizationContent? orgContent = settingsEntry.organizationContent;
            if (orgContent is models:OrganizationContent) {
                () organizationDetailsResponse = entry:orgContentDetails.add(orgContent);
                settingsResponse.organizationContent = organizationDetailsResponse;
            }
        }
        if (settingsEntry.kind.equalsIgnoreCaseAscii("themeContent")) {
            models:Theme? themeContent = settingsEntry.themeDetails;
            if (themeContent is models:Theme) {
                () themeDetailsResponse = entry:themeTable.add(themeContent);
                settingsResponse.themeDetails = themeDetailsResponse;
            }
        }
        return settingsResponse;
    }

    resource function get admin/settings/[string orgId](string kind) returns models:AdminSettings {

        models:AdminSettings settingsResponse = {
            kind: kind
        };

        if (kind.equalsIgnoreCaseAscii("themeContent")) {
            table<models:Theme> themeRecords = from var themeRecord in entry:themeTable
                where themeRecord.orgId == orgId
                select themeRecord;
            if (themeRecords.length() > 0) {
                settingsResponse.themeDetails = themeRecords.toArray().first()[0];
            }
        }

        if (kind.equalsIgnoreCaseAscii("oraganizationPageContent")) {
            table<models:OrganizationContent> orgContent = from var orgrecord in entry:orgContentDetails
                where orgrecord.orgId == orgId
                select orgrecord;
            if (orgContent.length() > 0) {
                settingsResponse.organizationContent = orgContent.toArray().first()[0];
            }

        }
        return settingsResponse;
    }

}

