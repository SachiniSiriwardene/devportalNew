public distinct service class ApiListingPage {

    private final readonly & ApiListingPageEntry? entryRecord;

    public function init(ApiListingPageEntry? entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get apiTilePalette() returns APITilePalette {
        APITilePaletteEntry apiTileDefinitionEntry = {
            'type: "",
            background: {primary: {light: "", dark: ""}, secondary: {light: "", dark: ""}},
            text: {primary: {light: "", dark: ""}, secondary: {light: "", dark: ""}},
            button: {primary: {light: "", dark: ""}, secondary: {light: "", dark: ""}}
        };

        ApiListingPageEntry apiListingPageEntry = self.entryRecord ?: {apiTilePalette: apiTileDefinitionEntry};
        return new APITilePalette(apiListingPageEntry.apiTilePalette);
    }
}
