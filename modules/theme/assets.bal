public distinct service class Assets {

    private final readonly & AssetsEntry entryRecord;

    public function init(AssetsEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
    resource function get fontFamily() returns AssetLogourl {
        return new AssetLogourl(self.entryRecord.logoUrl);
    }
}