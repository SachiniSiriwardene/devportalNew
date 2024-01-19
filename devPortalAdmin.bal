import devportal.models;
import devportal.entry;

import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service /devPortal/admin on new http:Listener(8000) {

    resource function post theme(@http:Payload models:Theme themeData) returns models:Theme | error{

        entry:themeTable.add(themeData);
        table<models:Theme> themeRecords = from var themeRecord in entry:themeTable
            where themeRecord.themeId == themeData.themeId
            select themeRecord;
        
        if (themeRecords.length() > 0) {
            return themeRecords.toArray().first()[0];
        }
        return error("Error while adding theme");
    }
    resource function get theme(string themeId) returns models:Theme | error {

        table<models:Theme> themeRecords = from var themeRecord in entry:themeTable
            where themeRecord.themeId == themeId
            select themeRecord;
        
        if (themeRecords.length() > 0) {
            return themeRecords.toArray().first()[0];
        }
        return error("Error while retrieving theme");
    }
}

