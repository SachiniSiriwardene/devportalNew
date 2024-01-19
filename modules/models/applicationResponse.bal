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

    resource function get users() returns UserResponse[] {

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