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

      def init(args) do
        GenServer.cast(__MODULE__, {:start_loop})
        {:ok, nil}
      end

      def start_link(_state \\ []) do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
      end

      @doc """
        Метод возвращает шары в виде %{url: count}
      """
      def get_shares do
        get_sorted_shares
        |> Enum.into(%{})
      end

      @doc """
       Метод возвращает упорядоченные шеры в виде [{url, count}]
      """
      def get_sorted_shares do
        shares = RedisClient.query(["ZREVRANGE",
          "shares:url:#{@social_name}", "0", "-1", "WITHSCORES"])
        shares
        |> Stream.chunk(2)
        |> Stream.map(&(List.to_tuple(&1)))
        |> Enum.map(&({elem(&1,0), String.to_integer elem(&1,1)}))
      end

      def handle_cast({:start_loop}, state) do
        Handler.urls_by_tags |> Enum.each(&rate_url(&1))
        GenServer.cast(__MODULE__, {:start_loop})
        {:noreply, Handler.urls_by_tags}
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
