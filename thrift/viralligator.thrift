enum TopicState {
  UNPUBLISHED,
  PUBLISHED
}

struct Topic {
  1: required string id;
  2: required string url;
  3: optional TopicState state = TopicState.UNPUBLISHED;
  4: optional i64 sharings;
}

service Viralligator {
  i64 topicsCount();
  Topic topic(1: string url);
  oneway void publish(1: Topic topic)
}
