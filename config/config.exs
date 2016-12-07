use Mix.Config

config :exredis,
  url: Application.get_env(:viralligator, :redis_url)
  reconnect: :no_reconnect,
  max_queue: :infinity

import_config "#{Mix.env}.exs"
