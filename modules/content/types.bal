# Represents content for the organization landin page.
#
# + orgContentId - unique identification for the organization  
# + organizationName - name of the organization  
# + orgId - field description  
# + orgBanner - image to be displayed in the organization landing page  
# + contentDescription - content to be displayed in the organization landing page
public  type OrganizationContent record {
    readonly string orgContentId;
    string organizationName;
    string orgId;
    string orgBanner;
    Contentdescription[] contentDescription;
};


# Represents content for a component landing page(API/Solution).
#
# + componentId - unique identification for the component  
# + orgId - unique identification for the organization  
# + sections - content to be displayed in the component/solutions landing page  
# + componentTileImage - image to be displayed in the component tile  
# + componentTileDescription - description to be displayed in the component tile
public type ComponentContent record {
    readonly string componentId;
    string orgId;
    Contentdescription[] sections;
    string componentTileImage;
    string componentTileDescription;
};

//input
# Represents a content section which is included in the landing pages.
#
# + precision - represents the order of the content section in the page  
# + description - description of the section  
# + title - heading of the section  
# + subtitle - sub heading of the section  
# + descriptionMarkDown - markdown content for the description of the section  
# + image - link to image shown in a section  
# + video - link to video shown in a section
# + bullets - list of points to be displayed in a content section
public type Contentdescription record {
    int precision;
    string description?;
    string title;
    string subtitle?;
    string descriptionMarkDown?;
    string image;
    string video;
    Item[] bullets?;
};

//input
# Represents a bulleted list which is included in a content section.
#
# + description - description of the bullet
# + icon - icon image for a bullet
public type Item record {
   string description;
   string icon?;
};


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
|};

public type Subscription record {|
    string[] subscribedAPIs;
|};

public type ConsumerComponentDetails record {|
    readonly string orgId;
    string userId;
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




