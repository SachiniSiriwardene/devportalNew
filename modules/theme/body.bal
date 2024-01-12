public distinct service class Body {

    private final readonly & BodyEntry entryRecord;

    public function init(BodyEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get fontFamily() returns string {
        return self.entryRecord.fontFamily;
    }
}