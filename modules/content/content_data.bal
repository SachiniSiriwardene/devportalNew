public table<OrganizationContent> key(orgContentId) orgContentDetails = table [
    {
        orgContentId: "308",
        "organizationName": "wso2",
        "orgBanner": "image1",
        "contentDescription": [

            {"precision": 1, "title": "Overview", "description": "ballerina", "subtitle": "ballerina", "descriptionMarkDown": "ballerina", image: "", video: ""},
            {"precision": 2, "title": "Features", "description": "feature1", "subtitle": "featireDescription", "descriptionMarkDown": "ballerina", image: "", video: ""},
            {
                "precision": 3,
                "title": "Advantages",
                "description": "advantage1",
                "subtitle": "ballerina",
                bullets: [
                    {"description": "bullet1", icon: "icon1"},
                    {"description": "bullet2", icon: "icon2"},
                    {"description": "bullet2"}
                ]
            ,
                image: "orgImage1",
                video: ""
            }
        ]
    , orgId: "1"}

];

public  table<ComponentContent> key(componentId) componentDetails = table [
    {
        "componentId": "1",
        "orgId": "308",
        "componentTileImage": "image1",
        "sections": [
            {"precision": 1, "title": "Overview", "description": "ballerina", "subtitle": "ballerina", "descriptionMarkDown": "ballerina", "image": "", "video": ""},
            {"precision": 2, "title": "Features", "description": "feature1", "subtitle": "featireDescription", "descriptionMarkDown": "ballerina", "image": "", "video": ""},
            {
                "precision": 3,
                "title": "Advantages",
                "description": "advantage1",
                "subtitle": "ballerina",
                bullets: [
                    {"description": "bullet1", icon: "icon1"},
                    {"description": "bullet2", icon: "icon2"},
                    {"description": "bullet2"}
                ]
            ,
                image: "",
                video: ""
            }
        ],
        "features": [
            {"description": "bullet1", icon: "icon1"},
            {"description": "bullet2", icon: "icon2"},
            {"description": "bullet2"}
        ],
        "developerKits": [
            {"description": "bullet1", icon: "icon1"},
            {"description": "bullet2", icon: "icon2"},
            {"description": "bullet2"}
        ]
    ,
        componentTileDescription: ""
    }
];

public table<Application> key(appId) applicationDetails = table [
    {
        "appId" : "1" , 
        "applicationName" : "ApplicationOne",
        "appProperties" : [{"name": "prop1", "value": "ABC"}, {"name": "prop2", "value": "ABCD"}],
        "addedAPIs" : ["api1"],
        "accessControl" : [
            {"role": "Developer", "userName": "John"}
        ]
    }
];

public table<Organization> key(orgId) organizationDetails = table [
    {
        "orgId" : "1",  "subscribedAPIs" : [ "API1"]
        
    }
];

public distinct service class OrganizationContentResponse {

    private final readonly & OrganizationContent entryRecord;

    public function init(OrganizationContent entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get orgId() returns string {
        return self.entryRecord.orgContentId;
    }

    resource function get organizationName() returns string {
        return self.entryRecord.organizationName;
    }

    resource function get bannerImage() returns string {
        return self.entryRecord.orgBanner;
    }

    resource function get contentDescription() returns ContentDescriptionResponse[] {
        ContentDescriptionResponse[] contentDescription = [];

        foreach var item in self.entryRecord.contentDescription {
            contentDescription.push(new ContentDescriptionResponse(item));
        }
        return contentDescription;
    }

}

public distinct service class ContentDescriptionResponse {

    private final readonly & Contentdescription entryRecord;

    function init(Contentdescription entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get precision() returns int {
        return self.entryRecord.precision;
    }

    resource function get title() returns string {
        return self.entryRecord.title;
    }

    resource function get description() returns string? {
        return self.entryRecord.description;
    }

    resource function get subtitle() returns string? {
        return self.entryRecord.subtitle;
    }

    resource function get descriptionMarkDown() returns string? {
        return self.entryRecord.descriptionMarkDown;
    }

    resource function get bullets() returns Bullets[]? {
        Bullets[] bullets = [];

        Item[] listItems = self.entryRecord.bullets ?: [];

        foreach var item in listItems {
            bullets.push(new Bullets(item));
        }
        return bullets;
    }

}

public distinct service class Bullets {

    private final readonly & Item entryRecord;

    function init(Item entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get description() returns string {
        return self.entryRecord.description;
    }

    resource function get icon() returns string? {
        return self.entryRecord.icon;
    }
}

public distinct service class ComponentDetails {

    private final readonly & ComponentContent entryRecord;

    public function init(ComponentContent entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get componentId() returns string {
        return self.entryRecord.componentId;
    }

    resource function get orgId() returns string {
        return self.entryRecord.orgId;
    }

    resource function get componentTileImage() returns string? {
        return self.entryRecord.componentTileImage;
    }

    resource function get sections() returns ContentDescriptionResponse[] {
        ContentDescriptionResponse[] contentDescription = [];

        foreach var item in self.entryRecord.sections {
            contentDescription.push(new ContentDescriptionResponse(item));
        }
        return contentDescription;
    }

}

public distinct service class OrganizationResponse {

    private final readonly & Organization organization;

    public function init(Organization entryRecord) {
        self.organization = entryRecord.cloneReadOnly();
    }
    resource function get subscription() returns string[] {
        return self.organization.subscribedAPIs;
    }

    resource function get orgId() returns string{
        return self.organization.orgId;
    }
}

public distinct service class SubscriptionResponse {

    private final readonly & Subscription subscription;

    function init(Subscription entryRecord) {
        self.subscription = entryRecord.cloneReadOnly();
    }

    resource function get subscribedAPIs() returns string[] {
        return self.subscription.subscribedAPIs;
    }
}

public distinct service class ApplicationResponse {

    private final readonly & Application app;

    public function init(Application entryRecord) {
        self.app = entryRecord.cloneReadOnly();
    }

    resource function get appId() returns string {
        return self.app.appId;
    }

    resource function get applicationName() returns string {
        return self.app.applicationName;
    }

    resource function get addedAPIs() returns string[] {
        return self.app.addedAPIs;
    }

    resource function get appProperties() returns ApplicationPropertiesResponse[] {

        ApplicationPropertiesResponse[] properties = [];

        foreach var item in self.app.appProperties {
            properties.push(new ApplicationPropertiesResponse(item));
        }
        return properties;
    }

    resource function get UserResponse() returns UserResponse[] {
        
        UserResponse[] users = [];

         foreach var item in self.app.accessControl {
            users.push(new UserResponse(item));
        }
        return users;

    }

}

public distinct service class ApplicationPropertiesResponse {

    private final readonly & ApplicationProperties appProperties;

    function init(ApplicationProperties entryRecord) {
        self.appProperties = entryRecord.cloneReadOnly();
    }

    resource function get name() returns string {
        return self.appProperties.name;
    }

    resource function get value() returns string {
        return self.appProperties.value;
    }
}

public distinct service class UserResponse {

    private final readonly & User user;

    function init(User entryRecord) {
        self.user = entryRecord.cloneReadOnly();
    }

    resource function get role() returns string{
         return self.user.role;
    }

    resource function get userName() returns string{
         return self.user.userName;
    }
    
}

