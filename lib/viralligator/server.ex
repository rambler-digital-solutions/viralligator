defmodule Viralligator.Server do
  @moduledoc  """
  Server module
  """

  alias Viralligator.Handler
  alias Viralligator.ShareService.Fb
  alias Viralligator.ShareService.Vk
  alias Viralligator.ShareService.Ok
  alias Viralligator.ShareService.Gplus

  use Riffed.Server,
    service: :viralligator_thrift,
    structs: Viralligator.Models,
    functions: [
      publish: &Handler.publish/2,
      sharings: &Handler.sharings/1,
      shares_by_url: &Handler.shares_by_url/1,
      total_shares: &Handler.total_shares/1,
      fb_shares: &Fb.get_sorted_shares/0,
      vk_shares: &Vk.get_sorted_shares/0,
      ok_shares: &Ok.get_sorted_shares/0,
      gplus_shares: &Gplus.get_sorted_shares/0
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
