public distinct service class PaletteButton {

    private final readonly & PaletteButtonEntry entryRecord;

    public function init(PaletteButtonEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get primary() returns PalettePrimary {
        return new PalettePrimary(self.entryRecord.primary);
    }
    resource function get secondary() returns PaletteSecondary {
        return new PaletteSecondary(self.entryRecord.secondary);
    }
}