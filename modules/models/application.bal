# Represents content to be included in the application section.
#
# + appId - application id  
# + applicationName - application name  
# + appProperties - list of properties as application information  
# + addedAPIs - list of added APIs for the application  
# + accessControl - access control for the application  
# + sandBoxKey - field description  
# + productionKey - field description  
# + idpId - field description
public type Application record {|
    readonly string appId;
    string applicationName;
    ApplicationProperties[] appProperties;
    string[] addedAPIs;
    User[] accessControl;
    string sandBoxKey;
    string productionKey;
    string idpId;
|};

public type Subscription record {|
    readonly string subscriptionId;
    string apiId;
    string orgId;
    string userId;
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