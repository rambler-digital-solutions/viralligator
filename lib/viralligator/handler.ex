defmodule Viralligator.Handler do
  @moduledoc """
    Handlers
  """
  use GenServer

  alias Viralligator.Models.Sharing
  alias Viralligator.ShareService
  alias Viralligator.RedisClient

  require IEx

  @ttl 172_800

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge(opts, name: __MODULE__))
  end

  def init(:ok) do
    {:ok, nil}
  end

  def topics_count do
    raw_count = RedisClient.query(["COMMAND", "COUNT"])
    {count, _} =  raw_count |> Integer.parse
    count
  end

  @doc """
  Запись топика в базу, по url
  """
  def topic(url) do
    binary_url = url |> IO.iodata_to_binary |> UriStringCanonical.canonical
    
		RedisClient.query_pipe(write_to_redis_query(binary_url))
    
    nil
  end

  @doc """
  Группирует в map результаты шерингов по каждой ссылке в базе
  """
  def sharings do
    urls = RedisClient.query(["KEYS", "*"])
    urls |> Enum.map(&shares_for_url/1)
  end

  @doc """
  Получение шаров по конкретному урлу
  """
  def shares_for_url(url) do
    binary_url = url |> IO.iodata_to_binary |> UriStringCanonical.canonical
    %Sharing{url: binary_url, shares: ShareService.shares(url)}
  end

  def handle_error(b, a) do
   IO.puts "Error #{a} -> #{b}!!!"
  end

	defp write_to_redis_query(binary_url) do
    [
      ["SET", binary_url, %{}],
      ["EXPIRE", binary_url, @ttl]
    ]
	end
end
