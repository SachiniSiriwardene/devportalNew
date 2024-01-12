public distinct service class APITilePalette {
    
    private final readonly & APITilePaletteEntry entryRecord;

    public function init(APITilePaletteEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get 'type() returns string {
        return self.entryRecord.'type;
    }

    resource function get background() returns PaletteBackground {
        return new PaletteBackground(self.entryRecord.background);
    }

    resource function get text() returns PaletteText {
        return new PaletteText(self.entryRecord.text);
    }
    resource function get button() returns PaletteButton {
        return new PaletteButton(self.entryRecord.button);
    }
}