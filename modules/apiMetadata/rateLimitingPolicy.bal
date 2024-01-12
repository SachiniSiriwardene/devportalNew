public distinct service class RateLimitingPolicy {
    private final readonly & RateLimitingPolicyEntry? entryRecord;

    public function init(RateLimitingPolicyEntry ?entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get policyName() returns string? {
        RateLimitingPolicyEntry rateLimitingPolicyEntry = self.entryRecord ?: {policyName: "", policyInfo: ""};
        return rateLimitingPolicyEntry.policyName;
    }
    resource function get policyInfo() returns string? {
       RateLimitingPolicyEntry rateLimitingPolicyEntry = self.entryRecord ?: {policyName: "", policyInfo: ""};
       return rateLimitingPolicyEntry.policyInfo;    
    }
}