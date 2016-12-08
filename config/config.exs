use Mix.Config

config :exredis, Viralligator,
  url: System.get_env("REDIS_URI") || "redis://127.0.0.1:6379/2",
  reconnect: :no_reconnect,
  max_queue: :infinity

import_config "#{Mix.env}.exs"
