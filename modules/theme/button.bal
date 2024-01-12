public distinct service class Button {

    private final readonly & ButtonEntry entryRecord;

    public function init(ButtonEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get fontFamily() returns string {
        return self.entryRecord.fontFamily;
    }
}