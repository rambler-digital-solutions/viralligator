defmodule Viralligator.ShareService.ShareServer do
  @moduledoc """
    Модуль для подключения к модулю соц.сети.
    Создаёт сервер, позволяющий обновлять и записывать в редис шеры,
    учитывая ограничения на кол-во запросов с стороны соцсети
  """
  defmacro __using__(_) do
    quote do
      use GenServer

      alias Viralligator.RedisClient
      alias Viralligator.Handler

      @avaliable_socials []

      def init(:ok, server_pid, initial_state) do
        {:ok, nil}
      end

      def start_link(_state \\ []) do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
        update_links
      end

      def update_links do
        GenServer.cast(__MODULE__, {:update_links})
      end

      def start_loop do
        GenServer.cast(__MODULE__, {:start_loop})
      end

      @doc """
        Метод возвращает шары в виде %{url: count}
      """
      def get_shares do
        shares = tl(RedisClient.query(["ZSCAN", "shares:url:#{@social_name}", "0"]))
        shares
        |> List.flatten
        |> Stream.chunk(2)
        |> Stream.map(&(List.to_tuple(&1)))
        |> Stream.map(&({elem(&1, 0), String.to_integer elem(&1, 1)}))
        |> Enum.into(%{})
      end

      def handle_cast({:update_links}, urls) do
        {:noreply, Handler.urls_by_tags}
      end

      def handle_cast({:start_loop}, urls) do
        urls |> Enum.each(&rate_url(&1))
        {:noreply, update_links}
      end

      defp rate_url(url) do
        RateLimitter.rate_loop(&update_share/1, url, @rate_limit, 0)
      end

      defp update_share(url) do
        shares = Handler.shares_by_url(url, @social_name)
        query = ["ZADD", "shares:url:#{@social_name}", shares.shares.count, url]
        RedisClient.query(query)
      end
    end
  end
end
