defmodule Viralligator.RedisClient do
  @moduledoc """
  Пример использования GenServer. Вызовы можно посмотреть в Viralligator.Handler
  """

  use GenServer

  # Api
  def query(params) do
    GenServer.call(__MODULE__, {:query, params})
  end

  def query_pipe(params) do
    GenServer.call(__MODULE__, {:query_pipe, params})
  end

  # For server
	def	init(redis_client) do
		{:ok, redis_client}
	end

  def handle_call({:query, params}, _from, redis) do
    result = redis |> Exredis.query(params)

    {:reply, result, redis}
  end

  def handle_call({:query_pipe, params}, _from, redis) do
    result = redis |> Exredis.query_pipe(params)

    {:reply, result, redis}
  end

  def start_link(state \\ []) do
    {:ok, redis_client} = Exredis.start_link
    GenServer.start_link(__MODULE__, redis_client, name: __MODULE__)
  end
end
