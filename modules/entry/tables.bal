import devportal.models;

public table<models:ApiMetadata> key(apiId) apiMetadataTable = table [
    {
        apiId: "123",
        orgId: "308",
        apiInfo: {
            apiName: "Pet Store",
            apiCategory: ["E-Commerce"],
            apiDocumentation: {precision: 0, title: "ABC Pet Store", image: "https://img.graphicsurf.com/2020/10/pet-shop-vector-design-concept.webp", video: ""},
            apiImage: "https://www.freepik.com/free-vector/pet-shop-illustration_6413813.htm#query=pet%20store&position=0&from_view=keyword&track=ais&uuid=2a3c9ba8-ad3e-4344-a977-e54f0755583b",
            lifeCycleStatus: "Published",
            openApiDefinition: "{}",
            additionalProperties: {}
        },
        throttlingPolicies: [],
        serverUrl: {sandboxUrl: "https://sandbox.api.petstore.com/v1/", productionUrl: "https://production.api.petstore.com/v1/"},
        feedback: {
            apiId: "123",
            averageRating: 4,
            noOfRating: 10,
            noOfComments: 8,
            reviews: [{reviewId: "456", reviewedBy: "divya@gmail.com", rating: 4, comment: "The API contains clear documentation and well-defined endpoints"}]
        },
        keyManagerUrl: {name: "Asgardeo", tokenEndpointUrl: "https://api.asgardeo.io/t/choreotestorganization/oauth2/token", revokeEndpointUrl: "https://api.asgardeo.io/t/choreotestorganization/oauth2/revoke", authorizeEndpointUrl: "https://api.asgardeo.io/t/choreotestorganization/oauth2/authorize"},
        apiDetailPageContent: {componentId: "234", orgId: "308", sections: [{precision: 1, description: "This API contains details about a Pet Store", title: "Pet Store API", subtitle: "API Definition", descriptionMarkDown: "ballerina", image: "https://www.vecteezy.com/vector-art/8927093-pet-shop-logo-design-template-with-cute-dog", video: "", bullets: [{description: "", icon: ""}]}], componentTileImage: "", componentTileDescription: ""}
    }
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

