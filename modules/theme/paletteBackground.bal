public distinct service class PaletteBackground {

    private final readonly & PaletteBackgroundEntry entryRecord;

    public function init(PaletteBackgroundEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get primary() returns PalettePrimary {
        return new PalettePrimary(self.entryRecord.primary);
    }
    resource function get secondary() returns PaletteSecondary {
        return new PaletteSecondary(self.entryRecord.secondary);
    }
}