struct Share {
  1: string social;
  2: i64 count;
}

struct Sharing {
  1: optional string url;
  2: optional list<Share> shares;
}

service Viralligator {
  void publish(1: string url, 2: list<string> tags);
  list<Sharing> sharings(1: list<string> tags);
  Sharing shares_by_url(1: string url);
  i64 total_shares(1: string url);
}
