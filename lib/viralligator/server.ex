defmodule Viralligator.Server do
  use Riffed.Server,
    service: :viralligator_thrift,
    structs: Viralligator.Models,
    functions: [topicsCount: &Viralligator.Handler.topics_count/0,
                getTopic: &Viralligator.Handler.get_topic/1],
    server: { :thrift_socket_server,
              port: 2112,
              framed: true,
              max: 10_000,
              socket_opts: [
                recv_timeout: 3000,
                keepalive: true
              ]}

  defenum TopicState do
    :unpublished -> 0
    :published -> 1
  end

  enumerize_struct Topic, state: TopicState
  enumerize_function getTopic(_), returns: TopicState
end
