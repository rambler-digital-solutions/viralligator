defmodule Viralligator.Server do
  @moduledoc  """
  Server module
  """

  alias Viralligator.Handler

  use Riffed.Server,
    service: :viralligator_thrift,
    structs: Viralligator.Models,
    functions: [
      topicsCount: &Handler.topics_count/0,
      topic: &Handler.topic/1,
      sharings: &Handler.sharings/0
    ],
    server: {:thrift_socket_server,
              port: 2112,
              framed: true,
              max: 10_000,
              socket_opts: [
                keepalive: false
              ]},
            error_handler: &Handler.handle_error/2
end
