public distinct service class ServerUrlEntry {
    private final readonly & ServerUrl entryRecord;

    public function init(ServerUrl entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get sandboxUrl() returns string {
        return self.entryRecord.sandboxUrl;
    }
    resource function get productionUrl() returns string {
        return self.entryRecord.productionUrl;
 
    }
}