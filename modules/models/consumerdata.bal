public type ConsumerComponentDetails record {|
    readonly string orgId;
    string userId;
    string[] subscribedAPIs;
    ConsumerReview comment;
|};

public type ConsumerReview record {|
    string APIId;
    string comment;
    int rating;
|};