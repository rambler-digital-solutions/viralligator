defmodule Viralligator.Handler do
  @moduledoc """
    Handlers
  """
  use GenServer

  alias Viralligator.Models.Sharing
  alias Viralligator.ShareService

  require IEx

  @ttl 172_800

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge(opts, name: __MODULE__))
  end

  def init(:ok) do
    {:ok, nil}
  end

  def topics_count do
    0
  end

  @doc """
  Запись топика в базу, по url
  """
  def topic(url) do
    binary_url = url |> IO.iodata_to_binary |> UriStringCanonical.canonical
    
    {:ok, client} = Exredis.start_link
    
    client |> Exredis.query(["SET", binary_url, %{}])
    client |> Exredis.query(["EXPIRE", binary_url, @ttl])
    
    client |> Exredis.stop
  end

  @doc """
  Группирует в map результаты шерингов по каждой ссылке в базе
  """
  def sharings do
    {:ok, client} = Exredis.start_link

    client
    |> Exredis.query(["KEYS", "*"])
    |> Enum.map(&shares_for_url/1)
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
end
