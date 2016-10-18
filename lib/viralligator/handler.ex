defmodule Viralligator.Handler do
  @moduledoc """
    Handlers
  """
  require Database.Topic

  use GenServer
  use Amnesia

  alias Viralligator.Models.Topic
  alias Viralligator.Models.Sharing
  alias Viralligator.ShareService

  require IEx

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge(opts, name: __MODULE__))
  end

  def init(:ok) do
    Amnesia.start

    {:ok, nil}
  end

  def topics_count do
    Amnesia.transaction do
      Database.Topic.count
    end
  end

  @doc """
  Запись топика в базу, по url
  """
  def topic(url) do
    binary_url = url |> IO.iodata_to_binary
    
    {:ok, client} = Exredis.start_link
    
    client |> Exredis.query(["SET", binary_url, %{}])
    
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
    |> List.first
  end

  def shares_for_url(url) do
    binary_url = url |> IO.iodata_to_binary
    %Sharing{url: binary_url, shares: ShareService.shares(url)}
  end

  def topic_by_url(url) do
    url
  end

  def handle_error(b, a) do
   IO.puts b
   IO.puts a
   IO.puts "ERrrorrr rererer!!!"
  end
end
