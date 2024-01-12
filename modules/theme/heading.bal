public distinct service class Heading {

    private final readonly & HeadingEntry entryRecord;

    public function init(HeadingEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get fontFamily() returns string {
        return self.entryRecord.fontFamily;
    }
}