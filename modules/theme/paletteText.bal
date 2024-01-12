public distinct service class PaletteText {

    private final readonly & PaletteTextEntry entryRecord;

    public function init(PaletteTextEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get primary() returns PalettePrimary {
        return new PalettePrimary(self.entryRecord.primary);
    }
    resource function get secondary() returns PaletteSecondary {
        return new PaletteSecondary(self.entryRecord.secondary);
    }
}