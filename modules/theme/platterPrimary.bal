public distinct service class PalettePrimary {

    private final readonly & PalettePrimaryEntry entryRecord;

    public function init(PalettePrimaryEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get light() returns string {
        return self.entryRecord.light;
    }
    resource function get dark() returns string {
        return self.entryRecord.dark;
    }
}