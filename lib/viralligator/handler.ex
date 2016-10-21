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
    raw_count |> Integer.parse |> elem(0)
  end

  @doc """
  Запись топика в базу, по url
  """
  def topic(url, tags) do
    url
    |> IO.iodata_to_binary
    |> UriStringCanonical.canonical
    |> &write_to_redis_query(&1, tags)
    |> RedisClient.query_pipe
    nil
  end

  @doc """
  Группирует в map результаты шерингов по каждой ссылке в базе
  """
  def sharings do
    urls = RedisClient.query(["KEYS", "viralligator:*"])
    urls |> Enum.map(&shares_by_url/1)
  end

  @doc """
  Получение шаров по конкретному урлу
  """
  def shares_by_url(url) do
    binary_url = url |> IO.iodata_to_binary |> UriStringCanonical.canonical
    %Sharing{url: binary_url, shares: ShareService.shares(url)}
  end

  def handle_error(b, a) do
   IO.puts "Error #{a} -> #{b}!!!"
  end

  defp write_to_redis_query(binary_url) do
    [
      ["SET", "viralligator:" <> binary_url, tags],
      ["EXPIRE", "viralligator:" <> binary_url, @ttl]
    ]
  end
end
