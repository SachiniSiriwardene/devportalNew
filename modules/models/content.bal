public type AdminSettings record {
    string organizationLandingPageContent;
    string themeContent;

};

public type AdminContent record {
    string fileURL;
};



# Represents content for the organization landin page.
#
# + organizationLandingPageContent - link to the content to display on the organization landing page

public  type OrganizationContent record {
    string organizationLandingPageContent;
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
    ContentDescription[] sections;
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
public type ContentDescription record {
    int precision;
    string description?;
    string title;
    string subtitle?;
    string descriptionMarkDown?;
    string image?;
    string video?;
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




