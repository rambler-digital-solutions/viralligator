defmodule Viralligator.ShareService.Fb do
  @moduledoc """
  Модуль для получения шаров с fb.com
  """
  use HTTPotion.{Base, Cache}
  use GenServer

  alias Viralligator.ShareService
  alias Viralligator.Models.Sharing
  alias Viralligator.RedisClient

  @social_name Fb

  def	init(:ok, server_pid, initial_state) do
    {:ok, nil}
  end

  def start_link(_state \\ []) do
    :timer.send_interval( get_interval, :update_shares )
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_info({:update_shares}, _from, urls) do
    urls = tl RedisClient.query(["SSCAN", "virraligator:tags:virraligator", "0"]) |> List.flatten
    res = urls
    |> Enum.map(&( %Sharing{url: &1, shares: ShareService.call(@social_name, &1)} ))
    # тут идет запись в редис
    {:noreply, res}
  end

  def get_interval do
    urls = length tl RedisClient.query(["SSCAN", "virraligator:tags:virraligator", "0"]) |> List.flatten
    
  end

  def handle_info(_, urls), do: {:noreply, urls}

  def process_url(url) do
    "https://graph.facebook.com/?id="
      <> url
      <> "&access_token=515263178664963|c3e8f07112daff2945b3abd70e023a20"
  end

  def process_response_body(body) do
    case body_fetcher(body) do
      {:ok, share} -> to_string(share["share_count"])
      _ -> "0"
    end
  end

  def body_fetcher(body) do
    body
    |> Poison.decode!
    |> Map.fetch("share")
  end
end

# Берем все ссылки и по кругу опрашиваем шэры
# Храним в Fb %Sharing{url: url, shares: count}
