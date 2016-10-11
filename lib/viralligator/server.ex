defmodule Viralligator.Server do
  @moduledoc  """
  Server module
  """

  use Riffed.Server,
    service: :viralligator_thrift,
    structs: Viralligator.Models,
    functions: [
      topicsCount: &Viralligator.Handler.topics_count/0,
      topic: &Viralligator.Handler.topic/1,
      publish: &Viralligator.Handler.publish/1
    ],
    server: { :thrift_socket_server,
              port: 2112,
              framed: true,
              max: 10_000,
              socket_opts: [
                keepalive: false
              ]},
            error_handler: &Viralligator.Handler.handle_error/2

  defenum TopicState do
    :unpublished -> 0
    :published -> 1
  end

  
  enumerize_struct Topic, state: TopicState
  enumerize_function topics_count(_), returns: Integer
end
