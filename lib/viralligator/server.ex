defmodule Viralligator.Server do
  @moduledoc  """
  Server module
  """

  alias Viralligator.Handler

  use Riffed.Server,
    service: :viralligator_thrift,
    structs: Viralligator.Models,
    functions: [
      publish: &Handler.publish/2,
      sharings: &Handler.sharings/1,
      shares_by_url: &Handler.shares_by_url/1,
      total_shares: &Handler.total_shares/1
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
