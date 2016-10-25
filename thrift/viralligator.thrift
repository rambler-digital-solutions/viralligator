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
  void publish(1: string url, 2: list<string> tags = []);
  list<Sharing> sharings(1: list<string> tags = []);
  list<Sharing> shares_by_url(1: string url);
}
