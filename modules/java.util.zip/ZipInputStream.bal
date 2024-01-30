import devportal.java.io as javaio;
import devportal.java.lang as javalang;
import devportal.java.nio.charset as javaniocharset;

import ballerina/jballerina.java;
import ballerina/jballerina.java.arrays as jarrays;

# Ballerina class mapping for the Java `java.util.zip.ZipInputStream` class.
@java:Binding {'class: "java.util.zip.ZipInputStream"}
public distinct class ZipInputStream {

    *java:JObject;
    *InflaterInputStream;

    # The `handle` field that stores the reference to the `java.util.zip.ZipInputStream` object.
    public handle jObj;

    # The init function of the Ballerina class mapping the `java.util.zip.ZipInputStream` Java class.
    #
    # + obj - The `handle` value containing the Java reference of the object.
    public function init(handle obj) {
        self.jObj = obj;
    }

    # The function to retrieve the string representation of the Ballerina class mapping the `java.util.zip.ZipInputStream` Java class.
    #
    # + return - The `string` form of the Java object instance.
    public function toString() returns string {
        return java:toString(self.jObj) ?: "";
    }
    # The function that maps to the `available` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function available() returns int|javaio:IOException {
        int|error externalObj = java_util_zip_ZipInputStream_available(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `close` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function close() returns javaio:IOException? {
        error|() externalObj = java_util_zip_ZipInputStream_close(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `closeEntry` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function closeEntry() returns javaio:IOException? {
        error|() externalObj = java_util_zip_ZipInputStream_closeEntry(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `equals` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `javalang:Object` value required to map with the Java method parameter.
    # + return - The `boolean` value returning from the Java mapping.
    public function 'equals(javalang:Object arg0) returns boolean {
        return java_util_zip_ZipInputStream_equals(self.jObj, arg0.jObj);
    }

    # The function that maps to the `getClass` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `javalang:Class` value returning from the Java mapping.
    public function getClass() returns javalang:Class {
        handle externalObj = java_util_zip_ZipInputStream_getClass(self.jObj);
        javalang:Class newObj = new (externalObj);
        return newObj;
    }

    # The function that maps to the `getNextEntry` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `ZipEntry` or the `javaio:IOException` value returning from the Java mapping.
    public function getNextEntry() returns ZipEntry|javaio:IOException {
        handle|error externalObj = java_util_zip_ZipInputStream_getNextEntry(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            ZipEntry newObj = new (externalObj);
            return newObj;
        }
    }

    # The function that maps to the `hashCode` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `int` value returning from the Java mapping.
    public function hashCode() returns int {
        return java_util_zip_ZipInputStream_hashCode(self.jObj);
    }

    # The function that maps to the `mark` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    public function mark(int arg0) {
        java_util_zip_ZipInputStream_mark(self.jObj, arg0);
    }

    # The function that maps to the `markSupported` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `boolean` value returning from the Java mapping.
    public function markSupported() returns boolean {
        return java_util_zip_ZipInputStream_markSupported(self.jObj);
    }

    # The function that maps to the `notify` method of `java.util.zip.ZipInputStream`.
    public function notify() {
        java_util_zip_ZipInputStream_notify(self.jObj);
    }

    # The function that maps to the `notifyAll` method of `java.util.zip.ZipInputStream`.
    public function notifyAll() {
        java_util_zip_ZipInputStream_notifyAll(self.jObj);
    }

    # The function that maps to the `read` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function read() returns int|javaio:IOException {
        int|error externalObj = java_util_zip_ZipInputStream_read(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `read` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `byte[]` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function read2(byte[] arg0) returns int|javaio:IOException|error {
        int|error externalObj = java_util_zip_ZipInputStream_read2(self.jObj, check jarrays:toHandle(arg0, "byte"));
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `read` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `byte[]` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + arg2 - The `int` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function read3(byte[] arg0, int arg1, int arg2) returns int|javaio:IOException|error {
        int|error externalObj = java_util_zip_ZipInputStream_read3(self.jObj, check jarrays:toHandle(arg0, "byte"), arg1, arg2);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `readAllBytes` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `byte[]` or the `javaio:IOException` value returning from the Java mapping.
    public function readAllBytes() returns byte[]|javaio:IOException|error {
        handle|error externalObj = java_util_zip_ZipInputStream_readAllBytes(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return <byte[]>check jarrays:fromHandle(externalObj, "byte");
        }
    }

    # The function that maps to the `readNBytes` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `byte[]` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + arg2 - The `int` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function readNBytes(byte[] arg0, int arg1, int arg2) returns int|javaio:IOException|error {
        int|error externalObj = java_util_zip_ZipInputStream_readNBytes(self.jObj, check jarrays:toHandle(arg0, "byte"), arg1, arg2);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `readNBytes` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `byte[]` or the `javaio:IOException` value returning from the Java mapping.
    public function readNBytes2(int arg0) returns byte[]|javaio:IOException|error {
        handle|error externalObj = java_util_zip_ZipInputStream_readNBytes2(self.jObj, arg0);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return <byte[]>check jarrays:fromHandle(externalObj, "byte");
        }
    }

    # The function that maps to the `reset` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function reset() returns javaio:IOException? {
        error|() externalObj = java_util_zip_ZipInputStream_reset(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `skip` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function skip(int arg0) returns int|javaio:IOException {
        int|error externalObj = java_util_zip_ZipInputStream_skip(self.jObj, arg0);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `skipNBytes` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function skipNBytes(int arg0) returns javaio:IOException? {
        error|() externalObj = java_util_zip_ZipInputStream_skipNBytes(self.jObj, arg0);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `transferTo` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `javaio:OutputStream` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function transferTo(javaio:OutputStream arg0) returns int|javaio:IOException {
        int|error externalObj = java_util_zip_ZipInputStream_transferTo(self.jObj, arg0.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `wait` method of `java.util.zip.ZipInputStream`.
    #
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function 'wait() returns javalang:InterruptedException? {
        error|() externalObj = java_util_zip_ZipInputStream_wait(self.jObj);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait2(int arg0) returns javalang:InterruptedException? {
        error|() externalObj = java_util_zip_ZipInputStream_wait2(self.jObj, arg0);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `java.util.zip.ZipInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait3(int arg0, int arg1) returns javalang:InterruptedException? {
        error|() externalObj = java_util_zip_ZipInputStream_wait3(self.jObj, arg0, arg1);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

}

# The constructor function to generate an object of `java.util.zip.ZipInputStream`.
#
# + arg0 - The `javaio:InputStream` value required to map with the Java constructor parameter.
# + return - The new `ZipInputStream` class generated.
public function newZipInputStream1(javaio:InputStream arg0) returns ZipInputStream {
    handle externalObj = java_util_zip_ZipInputStream_newZipInputStream1(arg0.jObj);
    ZipInputStream newObj = new (externalObj);
    return newObj;
}

# The constructor function to generate an object of `java.util.zip.ZipInputStream`.
#
# + arg0 - The `javaio:InputStream` value required to map with the Java constructor parameter.
# + arg1 - The `javaniocharset:Charset` value required to map with the Java constructor parameter.
# + return - The new `ZipInputStream` class generated.
public function newZipInputStream2(javaio:InputStream arg0, javaniocharset:Charset arg1) returns ZipInputStream {
    handle externalObj = java_util_zip_ZipInputStream_newZipInputStream2(arg0.jObj, arg1.jObj);
    ZipInputStream newObj = new (externalObj);
    return newObj;
}

# The function that maps to the `nullInputStream` method of `java.util.zip.ZipInputStream`.
#
# + return - The `javaio:InputStream` value returning from the Java mapping.
public function ZipInputStream_nullInputStream() returns javaio:InputStream {
    handle externalObj = java_util_zip_ZipInputStream_nullInputStream();
    javaio:InputStream newObj = new (externalObj);
    return newObj;
}

# The function that retrieves the value of the public field `LOCSIG`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCSIG() returns int {
    return java_util_zip_ZipInputStream_getLOCSIG();
}

# The function that retrieves the value of the public field `EXTSIG`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getEXTSIG() returns int {
    return java_util_zip_ZipInputStream_getEXTSIG();
}

# The function that retrieves the value of the public field `CENSIG`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENSIG() returns int {
    return java_util_zip_ZipInputStream_getCENSIG();
}

# The function that retrieves the value of the public field `ENDSIG`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDSIG() returns int {
    return java_util_zip_ZipInputStream_getENDSIG();
}

# The function that retrieves the value of the public field `LOCHDR`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCHDR() returns int {
    return java_util_zip_ZipInputStream_getLOCHDR();
}

# The function that retrieves the value of the public field `EXTHDR`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getEXTHDR() returns int {
    return java_util_zip_ZipInputStream_getEXTHDR();
}

# The function that retrieves the value of the public field `CENHDR`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENHDR() returns int {
    return java_util_zip_ZipInputStream_getCENHDR();
}

# The function that retrieves the value of the public field `ENDHDR`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDHDR() returns int {
    return java_util_zip_ZipInputStream_getENDHDR();
}

# The function that retrieves the value of the public field `LOCVER`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCVER() returns int {
    return java_util_zip_ZipInputStream_getLOCVER();
}

# The function that retrieves the value of the public field `LOCFLG`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCFLG() returns int {
    return java_util_zip_ZipInputStream_getLOCFLG();
}

# The function that retrieves the value of the public field `LOCHOW`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCHOW() returns int {
    return java_util_zip_ZipInputStream_getLOCHOW();
}

# The function that retrieves the value of the public field `LOCTIM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCTIM() returns int {
    return java_util_zip_ZipInputStream_getLOCTIM();
}

# The function that retrieves the value of the public field `LOCCRC`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCCRC() returns int {
    return java_util_zip_ZipInputStream_getLOCCRC();
}

# The function that retrieves the value of the public field `LOCSIZ`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCSIZ() returns int {
    return java_util_zip_ZipInputStream_getLOCSIZ();
}

# The function that retrieves the value of the public field `LOCLEN`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCLEN() returns int {
    return java_util_zip_ZipInputStream_getLOCLEN();
}

# The function that retrieves the value of the public field `LOCNAM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCNAM() returns int {
    return java_util_zip_ZipInputStream_getLOCNAM();
}

# The function that retrieves the value of the public field `LOCEXT`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getLOCEXT() returns int {
    return java_util_zip_ZipInputStream_getLOCEXT();
}

# The function that retrieves the value of the public field `EXTCRC`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getEXTCRC() returns int {
    return java_util_zip_ZipInputStream_getEXTCRC();
}

# The function that retrieves the value of the public field `EXTSIZ`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getEXTSIZ() returns int {
    return java_util_zip_ZipInputStream_getEXTSIZ();
}

# The function that retrieves the value of the public field `EXTLEN`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getEXTLEN() returns int {
    return java_util_zip_ZipInputStream_getEXTLEN();
}

# The function that retrieves the value of the public field `CENVEM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENVEM() returns int {
    return java_util_zip_ZipInputStream_getCENVEM();
}

# The function that retrieves the value of the public field `CENVER`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENVER() returns int {
    return java_util_zip_ZipInputStream_getCENVER();
}

# The function that retrieves the value of the public field `CENFLG`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENFLG() returns int {
    return java_util_zip_ZipInputStream_getCENFLG();
}

# The function that retrieves the value of the public field `CENHOW`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENHOW() returns int {
    return java_util_zip_ZipInputStream_getCENHOW();
}

# The function that retrieves the value of the public field `CENTIM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENTIM() returns int {
    return java_util_zip_ZipInputStream_getCENTIM();
}

# The function that retrieves the value of the public field `CENCRC`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENCRC() returns int {
    return java_util_zip_ZipInputStream_getCENCRC();
}

# The function that retrieves the value of the public field `CENSIZ`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENSIZ() returns int {
    return java_util_zip_ZipInputStream_getCENSIZ();
}

# The function that retrieves the value of the public field `CENLEN`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENLEN() returns int {
    return java_util_zip_ZipInputStream_getCENLEN();
}

# The function that retrieves the value of the public field `CENNAM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENNAM() returns int {
    return java_util_zip_ZipInputStream_getCENNAM();
}

# The function that retrieves the value of the public field `CENEXT`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENEXT() returns int {
    return java_util_zip_ZipInputStream_getCENEXT();
}

# The function that retrieves the value of the public field `CENCOM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENCOM() returns int {
    return java_util_zip_ZipInputStream_getCENCOM();
}

# The function that retrieves the value of the public field `CENDSK`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENDSK() returns int {
    return java_util_zip_ZipInputStream_getCENDSK();
}

# The function that retrieves the value of the public field `CENATT`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENATT() returns int {
    return java_util_zip_ZipInputStream_getCENATT();
}

# The function that retrieves the value of the public field `CENATX`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENATX() returns int {
    return java_util_zip_ZipInputStream_getCENATX();
}

# The function that retrieves the value of the public field `CENOFF`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getCENOFF() returns int {
    return java_util_zip_ZipInputStream_getCENOFF();
}

# The function that retrieves the value of the public field `ENDSUB`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDSUB() returns int {
    return java_util_zip_ZipInputStream_getENDSUB();
}

# The function that retrieves the value of the public field `ENDTOT`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDTOT() returns int {
    return java_util_zip_ZipInputStream_getENDTOT();
}

# The function that retrieves the value of the public field `ENDSIZ`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDSIZ() returns int {
    return java_util_zip_ZipInputStream_getENDSIZ();
}

# The function that retrieves the value of the public field `ENDOFF`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDOFF() returns int {
    return java_util_zip_ZipInputStream_getENDOFF();
}

# The function that retrieves the value of the public field `ENDCOM`.
#
# + return - The `int` value of the field.
public function ZipInputStream_getENDCOM() returns int {
    return java_util_zip_ZipInputStream_getENDCOM();
}

function java_util_zip_ZipInputStream_available(handle receiver) returns int|error = @java:Method {
    name: "available",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_close(handle receiver) returns error? = @java:Method {
    name: "close",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_closeEntry(handle receiver) returns error? = @java:Method {
    name: "closeEntry",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_equals(handle receiver, handle arg0) returns boolean = @java:Method {
    name: "equals",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["java.lang.Object"]
} external;

function java_util_zip_ZipInputStream_getClass(handle receiver) returns handle = @java:Method {
    name: "getClass",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_getNextEntry(handle receiver) returns handle|error = @java:Method {
    name: "getNextEntry",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_hashCode(handle receiver) returns int = @java:Method {
    name: "hashCode",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_mark(handle receiver, int arg0) = @java:Method {
    name: "mark",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["int"]
} external;

function java_util_zip_ZipInputStream_markSupported(handle receiver) returns boolean = @java:Method {
    name: "markSupported",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_notify(handle receiver) = @java:Method {
    name: "notify",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_notifyAll(handle receiver) = @java:Method {
    name: "notifyAll",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_nullInputStream() returns handle = @java:Method {
    name: "nullInputStream",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_read(handle receiver) returns int|error = @java:Method {
    name: "read",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_read2(handle receiver, handle arg0) returns int|error = @java:Method {
    name: "read",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["[B"]
} external;

function java_util_zip_ZipInputStream_read3(handle receiver, handle arg0, int arg1, int arg2) returns int|error = @java:Method {
    name: "read",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["[B", "int", "int"]
} external;

function java_util_zip_ZipInputStream_readAllBytes(handle receiver) returns handle|error = @java:Method {
    name: "readAllBytes",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_readNBytes(handle receiver, handle arg0, int arg1, int arg2) returns int|error = @java:Method {
    name: "readNBytes",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["[B", "int", "int"]
} external;

function java_util_zip_ZipInputStream_readNBytes2(handle receiver, int arg0) returns handle|error = @java:Method {
    name: "readNBytes",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["int"]
} external;

function java_util_zip_ZipInputStream_reset(handle receiver) returns error? = @java:Method {
    name: "reset",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_skip(handle receiver, int arg0) returns int|error = @java:Method {
    name: "skip",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["long"]
} external;

function java_util_zip_ZipInputStream_skipNBytes(handle receiver, int arg0) returns error? = @java:Method {
    name: "skipNBytes",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["long"]
} external;

function java_util_zip_ZipInputStream_transferTo(handle receiver, handle arg0) returns int|error = @java:Method {
    name: "transferTo",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["java.io.OutputStream"]
} external;

function java_util_zip_ZipInputStream_wait(handle receiver) returns error? = @java:Method {
    name: "wait",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: []
} external;

function java_util_zip_ZipInputStream_wait2(handle receiver, int arg0) returns error? = @java:Method {
    name: "wait",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["long"]
} external;

function java_util_zip_ZipInputStream_wait3(handle receiver, int arg0, int arg1) returns error? = @java:Method {
    name: "wait",
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["long", "int"]
} external;

function java_util_zip_ZipInputStream_getLOCSIG() returns int = @java:FieldGet {
    name: "LOCSIG",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getEXTSIG() returns int = @java:FieldGet {
    name: "EXTSIG",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENSIG() returns int = @java:FieldGet {
    name: "CENSIG",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDSIG() returns int = @java:FieldGet {
    name: "ENDSIG",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCHDR() returns int = @java:FieldGet {
    name: "LOCHDR",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getEXTHDR() returns int = @java:FieldGet {
    name: "EXTHDR",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENHDR() returns int = @java:FieldGet {
    name: "CENHDR",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDHDR() returns int = @java:FieldGet {
    name: "ENDHDR",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCVER() returns int = @java:FieldGet {
    name: "LOCVER",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCFLG() returns int = @java:FieldGet {
    name: "LOCFLG",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCHOW() returns int = @java:FieldGet {
    name: "LOCHOW",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCTIM() returns int = @java:FieldGet {
    name: "LOCTIM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCCRC() returns int = @java:FieldGet {
    name: "LOCCRC",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCSIZ() returns int = @java:FieldGet {
    name: "LOCSIZ",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCLEN() returns int = @java:FieldGet {
    name: "LOCLEN",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCNAM() returns int = @java:FieldGet {
    name: "LOCNAM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getLOCEXT() returns int = @java:FieldGet {
    name: "LOCEXT",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getEXTCRC() returns int = @java:FieldGet {
    name: "EXTCRC",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getEXTSIZ() returns int = @java:FieldGet {
    name: "EXTSIZ",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getEXTLEN() returns int = @java:FieldGet {
    name: "EXTLEN",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENVEM() returns int = @java:FieldGet {
    name: "CENVEM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENVER() returns int = @java:FieldGet {
    name: "CENVER",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENFLG() returns int = @java:FieldGet {
    name: "CENFLG",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENHOW() returns int = @java:FieldGet {
    name: "CENHOW",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENTIM() returns int = @java:FieldGet {
    name: "CENTIM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENCRC() returns int = @java:FieldGet {
    name: "CENCRC",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENSIZ() returns int = @java:FieldGet {
    name: "CENSIZ",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENLEN() returns int = @java:FieldGet {
    name: "CENLEN",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENNAM() returns int = @java:FieldGet {
    name: "CENNAM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENEXT() returns int = @java:FieldGet {
    name: "CENEXT",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENCOM() returns int = @java:FieldGet {
    name: "CENCOM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENDSK() returns int = @java:FieldGet {
    name: "CENDSK",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENATT() returns int = @java:FieldGet {
    name: "CENATT",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENATX() returns int = @java:FieldGet {
    name: "CENATX",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getCENOFF() returns int = @java:FieldGet {
    name: "CENOFF",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDSUB() returns int = @java:FieldGet {
    name: "ENDSUB",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDTOT() returns int = @java:FieldGet {
    name: "ENDTOT",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDSIZ() returns int = @java:FieldGet {
    name: "ENDSIZ",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDOFF() returns int = @java:FieldGet {
    name: "ENDOFF",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_getENDCOM() returns int = @java:FieldGet {
    name: "ENDCOM",
    'class: "java.util.zip.ZipInputStream"
} external;

function java_util_zip_ZipInputStream_newZipInputStream1(handle arg0) returns handle = @java:Constructor {
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["java.io.InputStream"]
} external;

function java_util_zip_ZipInputStream_newZipInputStream2(handle arg0, handle arg1) returns handle = @java:Constructor {
    'class: "java.util.zip.ZipInputStream",
    paramTypes: ["java.io.InputStream", "java.nio.charset.Charset"]
} external;

