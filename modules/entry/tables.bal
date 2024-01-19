import devportal.models;

public table<models:ApiMetadata> key(apiId) apiMetadataTable = table [
    ];

public table<models:Theme> key(themeId) themeTable = table [
    {
        typography: {
            heading: {
                fontFamily: "TimesNewRoman"
            },
            body: {
                fontFamily: "TimesNewRoman"
            },
            paragraph: {fontFamily: "Arial"}
        },
        assets: {logoUrl: {footer: "abc.com", favicon: "image1", header: "ABCD"}},
        themeId: "1",
        palette: {
            'type: "light",
            background: {secondary: {light: "#132", dark: "e44"}, primary: {light: "ddd", dark: "3233"}},
            text: {secondary: {light: "ee", dark: "qq"}, primary: {light: "33", dark: "434"}},
            button: {secondary: {light: "dwd", dark: "dede"}, primary: {light: "4344", dark: "4434"}}
        },
        footerLink: {terms: "terms", privacyPolicy: "privacy", support: "support"},
        orgId: "308"
    }
];

public table<models:OrganizationContent> key(orgContentId) orgContentDetails = table [
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
    ,
        orgId: "1"
    }

];

public table<models:ComponentContent> key(componentId) componentDetails = table [
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

public table<models:Application> key(appId) applicationDetails = table [
    {
        "appId": "1",
        "applicationName": "ApplicationOne",
        "appProperties": [{"name": "prop1", "value": "ABC"}, {"name": "prop2", "value": "ABCD"}],
        "addedAPIs": ["api1"],
        "accessControl": [
            {"role": "Developer", "userName": "John"}
        ]
    }
];

public table<models:ConsumerComponentDetails> key(orgId) organizationDetails = table [
    {
        "orgId": "1",
        "subscribedAPIs": ["API1"],
        userId: "abc.com",
        comment: {APIId: "", comment: "", rating: 0}
    }
];

