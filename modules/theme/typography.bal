public distinct service class Typography {

    private final readonly & TypographyEntry entryRecord;

    public function init(TypographyEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get headings() returns Heading {
        return new Heading(self.entryRecord.heading);
    }
    resource function get body() returns Body {
        return new Body(self.entryRecord.body);
    }
    resource function get paragraph() returns Paragraph {
        return new Paragraph(self.entryRecord.paragraph);
    }
}