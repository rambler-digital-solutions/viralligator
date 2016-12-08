defmodule Viralligator do
  @moduledoc """
  Main module
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Viralligator.Server, []),
      worker(Viralligator.RedisClient, []),
      worker(Viralligator.Handler, []),
      worker(Viralligator.ShareService.Vk, []),
      worker(Viralligator.ShareService.Fb, []),
      worker(Viralligator.ShareService.Gplus, []),
      worker(Viralligator.ShareService.Ok, []),
      worker(Cachex, [:http_cache, [default_ttl: :timer.minutes(15)]])
    ]
    
    opts = [strategy: :one_for_one, name: Viralligator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
