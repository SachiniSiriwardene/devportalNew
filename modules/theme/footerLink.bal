public distinct service class FooterLink {

    private final readonly & FooterLinkEntry entryRecord;
    
    public function init(FooterLinkEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get terms() returns string {
        return self.entryRecord.terms;
    }

    resource function get privacyPolicy() returns string {
        return self.entryRecord.privacyPolicy;
    }

    resource function get support() returns string {
        return self.entryRecord.support;
    }
}