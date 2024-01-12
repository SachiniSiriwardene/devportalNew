public type ThemeEntry record {|
    readonly string themeId;       
    APITilePaletteEntry palette;
    TypographyEntry typography;
    AssetsEntry assets;
    FooterLinkEntry footerLink;
    ApiListingPageEntry apiListingPage?;
|};

# Description.
#
# + 'type - field description  
# + background - field description  
# + text - field description  
# + button - field description
public type APITilePaletteEntry record {
    string 'type;
    PaletteBackgroundEntry background;
    PaletteTextEntry text;
    PaletteButtonEntry button;
};

public type PaletteBackgroundEntry record {
    PalettePrimaryEntry primary;
    PaletteSecondaryEntry secondary;
};

public type PaletteButtonEntry record {
    PalettePrimaryEntry primary;
    PaletteSecondaryEntry secondary;
};

public type FooterLinkEntry record {
    string terms;
    string privacyPolicy;
    string support;
};

public type ApiListingPageEntry record {
    APITilePaletteEntry apiTilePalette;
};

public type TypographyEntry record {
    HeadingEntry heading;
    BodyEntry body;
    ParagraphEntry paragraph;
};

public type ButtonEntry record {
    string fontFamily;
};

public type ParagraphEntry record {
    string fontFamily;
};


public type PalettePrimaryEntry record {
    string light;
    string dark;
};

public type PaletteSecondaryEntry record {
    string light;
    string dark;
};

public type HeadingEntry record {
    string fontFamily;
};

public type PaletteTextEntry record {
    PalettePrimaryEntry primary;
    PaletteSecondaryEntry secondary;
};

public type AssetLogourlEntry record {
    string header;
    string footer;
    string favicon;
};

public type AssetsEntry record {
    AssetLogourlEntry logoUrl;
};

public type BodyEntry record {
    string fontFamily;
};
