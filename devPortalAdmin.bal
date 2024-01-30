import devportal.java.io as javaio;
import devportal.java.util.zip as zip;
import devportal.models;

import ballerina/http;
import ballerina/io;

# A service representing a network-accessible API
# bound to port `9090`.
service /devPortalAdmin on new http:Listener(8080) {

    resource function post admin/organizationLandingPage(http:Request request) returns models:AdminContent {

        byte[]|http:ClientError binaryPayload = request.getBinaryPayload();
        stream<byte[], io:Error?>|http:ClientError byteSteam = request.getByteStream();

        if binaryPayload is byte[] {
            javaio:InputStream|error zipFile = javaio:newByteArrayInputStream1(binaryPayload);
            if (zipFile is javaio:InputStream) {
                zip:ZipInputStream zip = zip:newZipInputStream1(zipFile);
                zip:ZipEntry entry;
        //       while(zip.getNextEntry()!=null)
        // {

        // }
            }

        }

    }

    resource function post admin/apiLandingPage(http:Request request) returns models:AdminContent {

        byte[]|http:ClientError binaryPayload = request.getBinaryPayload();
        if (binaryPayload is byte[]) {

        }
        return {
            fileURL: ""
        };

    }

    resource function post admin/theme(http:Request request) returns string {

        return "";
    }

}

