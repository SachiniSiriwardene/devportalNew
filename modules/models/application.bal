# Represents content to be included in the application section.
#
# + appId - application id  
# + applicationName - application name  
# + appProperties - list of properties as application information  
# + accessControl - access control for the application  
# + addedAPIs - list of added APIs for the application
public type Application record {|
    readonly string appId;
    string applicationName;
    ApplicationProperties[] appProperties;
    string[] addedAPIs;
    User[] accessControl;
    string sandBoxKey;
    string productionKey;
|};

public type Subscription record {|
    string[] subscribedAPIs;
|};

public type Organization record {|
    readonly string orgId;
    string[] subscribedAPIs;
|};

public type ApplicationProperties record {
    string name;
    string value;
};

public type User record {|
    string role;
    string userName;
|};


public type API record {|
    string id;
    string name;
|};