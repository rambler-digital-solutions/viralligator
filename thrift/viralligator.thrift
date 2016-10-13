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

struct Sharing {
  1: optional string url;
  2: optional list<map<string, string>> shares;
}

service Viralligator {
  i64 topicsCount();
  Topic topic(1: string url);
  list<Sharing> sharings();
}
