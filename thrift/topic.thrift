enum TopicState {
  UNPUBLISHED,
  PUBLISHED
}

struct Topic {
  1: i64 id;
  2: string url;
  3: TopicState state = TopicState.UNPUBLISHED;
}

service Viralligator {
  i64 topicsCount();
  Topic getTopic(1: string url);
}
