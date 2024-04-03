# Response for content storage.
#
# + assetMappings - field description  
# + timeUploaded - field description
public type OrgContentResponse record {
    OrganizationAssets assetMappings;
    string timeUploaded;
};

# Response for organization creation.
#
# + assetMappings - field description  
# + timeUploaded - field description
public type OrgCreationResponse record {
    
    string orgName;
    string orgId;
};

# Response for API content storage.
#
# + assetMappings - field description  
# + timeUploaded - field description
public type APIContentResponse record {
    APIAssets assetMappings;
    string timeUploaded;
};



# Assets needed for the org landing page.
#
# + orgAssets - field description  
# + orgLandingPage - field description  
# + apiLandingPage - field description  
# + apiListingPage - field description  
# + navigationBar - field description  
# + footerPage - field description  
# + orgId - field description
public type OrganizationAssets record {|
    string orgAssets;
    string orgLandingPage;
    string apiLandingPage;
    string apiListingPage;
    string navigationBar;
    string footerPage;
    string orgId;
|};

# Assets needed for the api landing page.
#
# + apiImages - field description  
# + apiContent - field description  
# + apiId - field description
public type APIAssets record {|
    string[] apiImages;
    string apiContent;
    string apiId;
|};


# Description.
#
# + themeId - field description  
# + orgId - field description  
# + createdAt - field description
public type ThemeResponse record {
    string themeId;
    string orgId;
    string createdAt;
};

# Identity Provider configured for dev portal.
#
# + orgId - field description  
# + name - field description  
# + wellKnownEndpoint - field description  
# + introspectionEndpoint - field description  
# + issuer - field description  
# + jwksEndpoint - field description  
# + authorizeEndpoint - field description  
# + envrionments - field description
public type IdentityProvider record {
    string orgId;
    string name;
    string wellKnownEndpoint;
    string introspectionEndpoint;
    string issuer;
    string jwksEndpoint;
    string authorizeEndpoint;
    string envrionments;
};

# Response for IdentityProvider creaton.
#
# + id - field description  
# + idpName - field description  
# + createdAt - field description
public type IdentityProviderResponse record {
    string id;
    string idpName;
    string createdAt;
};





