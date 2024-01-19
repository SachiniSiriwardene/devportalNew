public type ConsumerComponentDetails record {|
    readonly string orgId;
    string userId;
    string[] subscribedAPIs;
    Comments comment;
|};

public type Comments record {|
    string APIId;
    string comment;
    int rating;
|};