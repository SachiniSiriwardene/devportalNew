public distinct service class Theme {
    private final readonly & ThemeEntry entryRecord;

    public function init(ThemeEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get themeId() returns string {
        return self.entryRecord.themeId;
    }
    resource function get palette() returns APITilePalette {
        return new APITilePalette(self.entryRecord.palette);
    }
    resource function get typography() returns Typography {
        return new Typography(self.entryRecord.typography);
    }
    resource function get assets() returns Assets {
        return new Assets(self.entryRecord.assets);
    }
    resource function get footerLink() returns FooterLink {
        return new FooterLink(self.entryRecord.footerLink);
    }
    resource function get homePage() returns ApiListingPage {
        return new ApiListingPage(self.entryRecord.apiListingPage);
    }
}