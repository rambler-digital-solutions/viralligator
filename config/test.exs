use Mix.Config

config :exredis,
  url: System.get_env("REDIS_URL") || "redis://127.0.0.1:6379/10",
  reconnect: :no_reconnect,
  max_queue: :infinity
