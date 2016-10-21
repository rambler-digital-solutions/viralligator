enum TopicState {
  UNPUBLISHED,
  PUBLISHED
}

struct Topic {
  1: required i64 id;
  2: required string url;
  3: optional TopicState state = TopicState.UNPUBLISHED;
  4: optional map<string, i64> sharings;
}

struct Share {
  1: string social;
  2: i64 count;
}

struct Sharing {
  1: optional string url;
  2: optional list<Share> shares;
}

service Viralligator {
  i64 topicsCount();
  void topic(1: string url);
  list<Sharing> sharings();
  list<Sharing> shares_by_url(1: string url);
}
