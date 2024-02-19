public type Theme record {|
    readonly string themeId;   
    string orgName; 
    string templateName;   
    string orgLandingPageUrl;
    APITilePalette palette;
    Typography typography;
    Assets assets;
    FooterLink footerLink;
    ApiListingPage apiListingPage?;
|};

# Description.
#
# + 'type - field description  
# + background - field description  
# + text - field description  
# + button - field description
public type APITilePalette record {
    string 'type;
    PaletteBackground background;
    PaletteText text;
    PaletteButton button;
};

public type PaletteBackground record {
    PalettePrimary primary;
    PaletteSecondary secondary;
};

public type PaletteButton record {
    PalettePrimary primary;
    PaletteSecondary secondary;
};

public type FooterLink record {
    string terms;
    string privacyPolicy;
    string support;
};

public type ApiListingPage record {
    APITilePalette apiTilePalette;
};

public type Typography record {
    Heading heading;
    Body body;
    Paragraph paragraph;
};

public type Button record {
    string fontFamily;
};

public type Paragraph record {
    string fontFamily;
};


public type PalettePrimary record {
    string light;
    string dark;
};

public type PaletteSecondary record {
    string light;
    string dark;
};

public type Heading record {
    string fontFamily;
};

public type PaletteText record {
    PalettePrimary primary;
    PaletteSecondary secondary;
};

public type AssetLogourl record {
    string header;
    string footer;
    string favicon;
};

public type Assets record {
    AssetLogourl logoUrl;
};

public type Body record {
    string fontFamily;
};
