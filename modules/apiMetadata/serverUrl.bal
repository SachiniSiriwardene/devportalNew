public distinct service class ServerUrl {
    private final readonly & ServerUrlEntry entryRecord;

    public function init(ServerUrlEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get sandboxUrl() returns string {
        return self.entryRecord.sandboxUrl;
    }
    resource function get productionUrl() returns string {
        return self.entryRecord.productionUrl;
 
    }
}