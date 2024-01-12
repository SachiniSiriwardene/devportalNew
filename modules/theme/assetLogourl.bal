public distinct service class AssetLogourl {

    private final readonly & AssetLogourlEntry entryRecord;

    public function init(AssetLogourlEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get header() returns string {
        return self.entryRecord.header;
    }
    resource function get footer() returns string {
        return self.entryRecord.footer;
    }
    resource function get favicon() returns string {
        return self.entryRecord.favicon;
    }
}