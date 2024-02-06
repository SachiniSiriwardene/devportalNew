

public distinct service class ConsumerReviewResponse {
    private final readonly & ConsumerReview comments;

    public function init(ConsumerReview entryRecord) {
        self.comments = entryRecord.cloneReadOnly();
    }

    resource function get APIId() returns string {
        return self.comments.apiId;
    }

    resource function get comment() returns string {
        return self.comments.comment;
    }

    resource function get rating() returns int {
        return self.comments.rating;
    }

     resource function get userId() returns string {
        return self.comments.userId;
    }
}

public distinct service class SubscriptionResponse {

    private final readonly & APISubscription subscription;

    public function init(APISubscription entryRecord) {
        self.subscription = entryRecord.cloneReadOnly();
    }

    resource function get subscribedAPIs() returns string {
        return self.subscription.apiId;
    }

       resource function get orgId() returns string {
        return self.subscription.orgId;
    }

     resource function get userId() returns string {
        return self.subscription.userId;
    }

     resource function get subscriptionId() returns string {
        return self.subscription.subscriptionId;
    }
}
