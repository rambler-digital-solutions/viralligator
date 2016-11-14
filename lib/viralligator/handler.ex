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
  @redis_namespace "viralligator:"

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge(opts, name: __MODULE__))
  end

  def init(:ok) do
    {:ok, nil}
  end

  @doc """
  Запись топика в базу, по url
  """
  def publish(url, tags \\ []) do
    url
    |> UriStringCanonical.binary_canonical
    |> (&write_to_redis_query(&1, tags ++ ["viralligator"])).()
    |> RedisClient.query_pipe
    nil
  end

  @doc """
  Группирует в map результаты шерингов по каждой ссылке в базе
  """
  def sharings(tags \\ ["viralligator"]) do
    tags
    |> Enum.map(&to_string/1)
    |> urls_by_tags
    |> Enum.map(fn url -> {url, total_shares(url)} end)
    |> Enum.sort(&(elem(&1, 1) > elem(&2, 1)))
  end

  @doc """
  Получение шаров по конкретному урлу
  """
  def shares_by_url(url) do
    binary_url = UriStringCanonical.binary_canonical(url)
    %Sharing{url: binary_url, shares: ShareService.shares(binary_url)}
  end

  @doc """
  Получение шаров по конкретному урлу для конкретной соц. сети
  """
  def shares_by_url(url, social_name) do
    binary_url = UriStringCanonical.binary_canonical(url)
    %Sharing{url: binary_url, shares: ShareService.shares(binary_url, social_name)}
  end

  @doc """
  Список урлов по тэгам
  """
  def urls_by_tags(tags \\ []) do
    tags_tmp = tags |> normalize_tags
    query = ["SINTER"] ++ tags_tmp ++ ["viralligator:tags:viralligator"]
    result = RedisClient.query(query)
    result |> remove_namespace
  end

  @doc """
  Приведение тегов к бинарным строкам и добавление неймспейса
  """
  def normalize_tags(tags) do
    tags
    |> Enum.map(&to_string/1)
    |> Enum.map(&IO.iodata_to_binary/1)
    |> Enum.map(&(@redis_namespace <> "tags:" <> &1))
  end

  @doc """
  Получение общего количества шеров
  """
  def total_shares(url) do
    binary_url = UriStringCanonical.binary_canonical(url)

    ShareService.list_services
    |> Stream.map(&ShareService.social_module(&1))
    |> Stream.map(fn service -> service.get_shares end)
    |> Stream.reject(fn shares -> !Map.has_key?(shares, binary_url) end)
    |> Enum.reduce(0, &(&1[binary_url] + &2))
  end

  @doc """
  Обработка ошибок
  """
  def handle_error(b, a), do: IO.puts "Error #{a} -> #{b}!!!"

  defp remove_namespace(strings), do:
    strings |> Enum.map(&String.replace(&1, @redis_namespace, ""))

  defp write_to_redis_query(binary_url, tags) do
    tags_query = Enum.map(tags,
     &(["SADD", @redis_namespace <> "tags:" <> &1, binary_url]))

    tags_query ++ [["EXPIRE", @redis_namespace <> binary_url, @ttl]]
  end
end
