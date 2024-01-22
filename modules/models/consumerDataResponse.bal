public distinct service class ConsuemrComponentDetailsResponse {

    private final readonly & ConsumerComponentDetails organization;
    
    public function init(ConsumerComponentDetails entryRecord) {
        self.organization = entryRecord.cloneReadOnly();
    }
    resource function get subscription() returns string[] {
        return self.organization.subscribedAPIs;
    }

    resource function get orgId() returns string{
        return self.organization.orgId;
    }

    resource function get comments() returns CommentResponse {
        return new (self.organization.comment);
    }
}

public distinct service class CommentResponse {
    private final readonly & ConsumerReview comments;

    public function init(ConsumerReview entryRecord) {
        self.comments = entryRecord.cloneReadOnly();
    }

    resource function get APIId() returns string {
        return self.comments.APIId;
    }

    resource function get comment() returns string {
        return self.comments.comment;
    }

    resource function get rating() returns int {
        return self.comments.rating;
    }



}

public distinct service class SubscriptionResponse {

    private final readonly & Subscription subscription;

    function init(Subscription entryRecord) {
        self.subscription = entryRecord.cloneReadOnly();
    }

    resource function get subscribedAPIs() returns string[] {
        return self.subscription.subscribedAPIs;
    }
}
