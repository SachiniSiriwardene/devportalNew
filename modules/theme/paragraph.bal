public distinct service class Paragraph {

    private final readonly & ParagraphEntry entryRecord;

    public function init(ParagraphEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get fontFamily() returns string {
        return self.entryRecord.fontFamily;
    }
}