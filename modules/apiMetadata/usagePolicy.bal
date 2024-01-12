public distinct service class UsagePolicy {
    private final readonly & UsagePolicyEntry entryRecord;

    public function init(UsagePolicyEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get policyName() returns string {
        return self.entryRecord.policyName;
    }
    resource function get policyInfo() returns string {
        return self.entryRecord.policyInfo;
    }
}