# Represents content for the organization landin page.
#
# + organizationName - name of the organization  
# + orgId - organization identifier  
# + organizationLandingPageContent - link to the content to display on the organization landing page
public  type OrganizationContent record {
    string organizationName;
    readonly string orgId;
    string organizationLandingPageContent;
};