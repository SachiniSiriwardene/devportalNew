# Response for content storage.
#
# + fileNames - field description  
# + createdAt - field description
public type ContentResponse record {
    string[] fileNames;
    string timeUploaded;
};

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
    string[] envrionments;
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





