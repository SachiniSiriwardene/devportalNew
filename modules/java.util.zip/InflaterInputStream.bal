import devportal.java.io as javaio;
import devportal.java.lang as javalang;

import ballerina/jballerina.java;
import ballerina/jballerina.java.arrays as jarrays;

# Ballerina class mapping for the Java `java.util.zip.InflaterInputStream` class.
@java:Binding {'class: "java.util.zip.InflaterInputStream"}
public distinct class InflaterInputStream {

    *java:JObject;
    *javaio:FilterInputStream;

    # The `handle` field that stores the reference to the `java.util.zip.InflaterInputStream` object.
    public handle jObj;

    # The init function of the Ballerina class mapping the `java.util.zip.InflaterInputStream` Java class.
    #
    # + obj - The `handle` value containing the Java reference of the object.
    public function init(handle obj) {
        self.jObj = obj;
    }

    # The function to retrieve the string representation of the Ballerina class mapping the `java.util.zip.InflaterInputStream` Java class.
    #
    # + return - The `string` form of the Java object instance.
    public function toString() returns string {
        return java:toString(self.jObj) ?: "";
    }
    # The function that maps to the `available` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function available() returns int|javaio:IOException {
        int|error externalObj = java_util_zip_InflaterInputStream_available(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `close` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function close() returns javaio:IOException? {
        error|() externalObj = java_util_zip_InflaterInputStream_close(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `equals` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `javalang:Object` value required to map with the Java method parameter.
    # + return - The `boolean` value returning from the Java mapping.
    public function 'equals(javalang:Object arg0) returns boolean {
        return java_util_zip_InflaterInputStream_equals(self.jObj, arg0.jObj);
    }

    # The function that maps to the `getClass` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `javalang:Class` value returning from the Java mapping.
    public function getClass() returns javalang:Class {
        handle externalObj = java_util_zip_InflaterInputStream_getClass(self.jObj);
        javalang:Class newObj = new (externalObj);
        return newObj;
    }

    # The function that maps to the `hashCode` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `int` value returning from the Java mapping.
    public function hashCode() returns int {
        return java_util_zip_InflaterInputStream_hashCode(self.jObj);
    }

    # The function that maps to the `mark` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    public function mark(int arg0) {
        java_util_zip_InflaterInputStream_mark(self.jObj, arg0);
    }

    # The function that maps to the `markSupported` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `boolean` value returning from the Java mapping.
    public function markSupported() returns boolean {
        return java_util_zip_InflaterInputStream_markSupported(self.jObj);
    }

    # The function that maps to the `notify` method of `java.util.zip.InflaterInputStream`.
    public function notify() {
        java_util_zip_InflaterInputStream_notify(self.jObj);
    }

    # The function that maps to the `notifyAll` method of `java.util.zip.InflaterInputStream`.
    public function notifyAll() {
        java_util_zip_InflaterInputStream_notifyAll(self.jObj);
    }

    # The function that maps to the `read` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function read() returns int|javaio:IOException {
        int|error externalObj = java_util_zip_InflaterInputStream_read(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `read` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `byte[]` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function read2(byte[] arg0) returns int|javaio:IOException|error {
        int|error externalObj = java_util_zip_InflaterInputStream_read2(self.jObj, check jarrays:toHandle(arg0, "byte"));
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `read` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `byte[]` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + arg2 - The `int` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function read3(byte[] arg0, int arg1, int arg2) returns int|javaio:IOException|error {
        int|error externalObj = java_util_zip_InflaterInputStream_read3(self.jObj, check jarrays:toHandle(arg0, "byte"), arg1, arg2);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `readAllBytes` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `byte[]` or the `javaio:IOException` value returning from the Java mapping.
    public function readAllBytes() returns byte[]|javaio:IOException|error {
        handle|error externalObj = java_util_zip_InflaterInputStream_readAllBytes(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return <byte[]>check jarrays:fromHandle(externalObj, "byte");
        }
    }

    # The function that maps to the `readNBytes` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `byte[]` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + arg2 - The `int` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function readNBytes(byte[] arg0, int arg1, int arg2) returns int|javaio:IOException|error {
        int|error externalObj = java_util_zip_InflaterInputStream_readNBytes(self.jObj, check jarrays:toHandle(arg0, "byte"), arg1, arg2);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `readNBytes` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `byte[]` or the `javaio:IOException` value returning from the Java mapping.
    public function readNBytes2(int arg0) returns byte[]|javaio:IOException|error {
        handle|error externalObj = java_util_zip_InflaterInputStream_readNBytes2(self.jObj, arg0);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return <byte[]>check jarrays:fromHandle(externalObj, "byte");
        }
    }

    # The function that maps to the `reset` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function reset() returns javaio:IOException? {
        error|() externalObj = java_util_zip_InflaterInputStream_reset(self.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `skip` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function skip(int arg0) returns int|javaio:IOException {
        int|error externalObj = java_util_zip_InflaterInputStream_skip(self.jObj, arg0);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `skipNBytes` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javaio:IOException` value returning from the Java mapping.
    public function skipNBytes(int arg0) returns javaio:IOException? {
        error|() externalObj = java_util_zip_InflaterInputStream_skipNBytes(self.jObj, arg0);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `transferTo` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `javaio:OutputStream` value required to map with the Java method parameter.
    # + return - The `int` or the `javaio:IOException` value returning from the Java mapping.
    public function transferTo(javaio:OutputStream arg0) returns int|javaio:IOException {
        int|error externalObj = java_util_zip_InflaterInputStream_transferTo(self.jObj, arg0.jObj);
        if (externalObj is error) {
            javaio:IOException e = error javaio:IOException(javaio:IOEXCEPTION, externalObj, message = externalObj.message());
            return e;
        } else {
            return externalObj;
        }
    }

    # The function that maps to the `wait` method of `java.util.zip.InflaterInputStream`.
    #
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function 'wait() returns javalang:InterruptedException? {
        error|() externalObj = java_util_zip_InflaterInputStream_wait(self.jObj);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait2(int arg0) returns javalang:InterruptedException? {
        error|() externalObj = java_util_zip_InflaterInputStream_wait2(self.jObj, arg0);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `java.util.zip.InflaterInputStream`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait3(int arg0, int arg1) returns javalang:InterruptedException? {
        error|() externalObj = java_util_zip_InflaterInputStream_wait3(self.jObj, arg0, arg1);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

}

# The constructor function to generate an object of `java.util.zip.InflaterInputStream`.
#
# + arg0 - The `javaio:InputStream` value required to map with the Java constructor parameter.
# + return - The new `InflaterInputStream` class generated.
public function newInflaterInputStream1(javaio:InputStream arg0) returns InflaterInputStream {
    handle externalObj = java_util_zip_InflaterInputStream_newInflaterInputStream1(arg0.jObj);
    InflaterInputStream newObj = new (externalObj);
    return newObj;
}

# The constructor function to generate an object of `java.util.zip.InflaterInputStream`.
#
# + arg0 - The `javaio:InputStream` value required to map with the Java constructor parameter.
# + arg1 - The `Inflater` value required to map with the Java constructor parameter.
# + return - The new `InflaterInputStream` class generated.
public function newInflaterInputStream2(javaio:InputStream arg0, Inflater arg1) returns InflaterInputStream {
    handle externalObj = java_util_zip_InflaterInputStream_newInflaterInputStream2(arg0.jObj, arg1.jObj);
    InflaterInputStream newObj = new (externalObj);
    return newObj;
}

# The constructor function to generate an object of `java.util.zip.InflaterInputStream`.
#
# + arg0 - The `javaio:InputStream` value required to map with the Java constructor parameter.
# + arg1 - The `Inflater` value required to map with the Java constructor parameter.
# + arg2 - The `int` value required to map with the Java constructor parameter.
# + return - The new `InflaterInputStream` class generated.
public function newInflaterInputStream3(javaio:InputStream arg0, Inflater arg1, int arg2) returns InflaterInputStream {
    handle externalObj = java_util_zip_InflaterInputStream_newInflaterInputStream3(arg0.jObj, arg1.jObj, arg2);
    InflaterInputStream newObj = new (externalObj);
    return newObj;
}

# The function that maps to the `nullInputStream` method of `java.util.zip.InflaterInputStream`.
#
# + return - The `javaio:InputStream` value returning from the Java mapping.
public function InflaterInputStream_nullInputStream() returns javaio:InputStream {
    handle externalObj = java_util_zip_InflaterInputStream_nullInputStream();
    javaio:InputStream newObj = new (externalObj);
    return newObj;
}

function java_util_zip_InflaterInputStream_available(handle receiver) returns int|error = @java:Method {
    name: "available",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_close(handle receiver) returns error? = @java:Method {
    name: "close",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_equals(handle receiver, handle arg0) returns boolean = @java:Method {
    name: "equals",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["java.lang.Object"]
} external;

function java_util_zip_InflaterInputStream_getClass(handle receiver) returns handle = @java:Method {
    name: "getClass",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_hashCode(handle receiver) returns int = @java:Method {
    name: "hashCode",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_mark(handle receiver, int arg0) = @java:Method {
    name: "mark",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["int"]
} external;

function java_util_zip_InflaterInputStream_markSupported(handle receiver) returns boolean = @java:Method {
    name: "markSupported",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_notify(handle receiver) = @java:Method {
    name: "notify",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_notifyAll(handle receiver) = @java:Method {
    name: "notifyAll",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_nullInputStream() returns handle = @java:Method {
    name: "nullInputStream",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_read(handle receiver) returns int|error = @java:Method {
    name: "read",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_read2(handle receiver, handle arg0) returns int|error = @java:Method {
    name: "read",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["[B"]
} external;

function java_util_zip_InflaterInputStream_read3(handle receiver, handle arg0, int arg1, int arg2) returns int|error = @java:Method {
    name: "read",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["[B", "int", "int"]
} external;

function java_util_zip_InflaterInputStream_readAllBytes(handle receiver) returns handle|error = @java:Method {
    name: "readAllBytes",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_readNBytes(handle receiver, handle arg0, int arg1, int arg2) returns int|error = @java:Method {
    name: "readNBytes",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["[B", "int", "int"]
} external;

function java_util_zip_InflaterInputStream_readNBytes2(handle receiver, int arg0) returns handle|error = @java:Method {
    name: "readNBytes",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["int"]
} external;

function java_util_zip_InflaterInputStream_reset(handle receiver) returns error? = @java:Method {
    name: "reset",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_skip(handle receiver, int arg0) returns int|error = @java:Method {
    name: "skip",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["long"]
} external;

function java_util_zip_InflaterInputStream_skipNBytes(handle receiver, int arg0) returns error? = @java:Method {
    name: "skipNBytes",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["long"]
} external;

function java_util_zip_InflaterInputStream_transferTo(handle receiver, handle arg0) returns int|error = @java:Method {
    name: "transferTo",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["java.io.OutputStream"]
} external;

function java_util_zip_InflaterInputStream_wait(handle receiver) returns error? = @java:Method {
    name: "wait",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: []
} external;

function java_util_zip_InflaterInputStream_wait2(handle receiver, int arg0) returns error? = @java:Method {
    name: "wait",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["long"]
} external;

function java_util_zip_InflaterInputStream_wait3(handle receiver, int arg0, int arg1) returns error? = @java:Method {
    name: "wait",
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["long", "int"]
} external;

function java_util_zip_InflaterInputStream_newInflaterInputStream1(handle arg0) returns handle = @java:Constructor {
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["java.io.InputStream"]
} external;

function java_util_zip_InflaterInputStream_newInflaterInputStream2(handle arg0, handle arg1) returns handle = @java:Constructor {
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["java.io.InputStream", "java.util.zip.Inflater"]
} external;

function java_util_zip_InflaterInputStream_newInflaterInputStream3(handle arg0, handle arg1, int arg2) returns handle = @java:Constructor {
    'class: "java.util.zip.InflaterInputStream",
    paramTypes: ["java.io.InputStream", "java.util.zip.Inflater", "int"]
} external;

