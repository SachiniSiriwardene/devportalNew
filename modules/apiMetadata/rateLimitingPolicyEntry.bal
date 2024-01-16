public distinct service class RateLimitingPolicyEntry {
    private final readonly & RateLimitingPolicy? entryRecord;

    public function init(RateLimitingPolicy ?entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }
}