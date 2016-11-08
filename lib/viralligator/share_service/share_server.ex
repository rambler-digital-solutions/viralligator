defmodule Viralligator.ShareService.ShareServer do
  @doc """
    Модуль для подключения к модулю соц.сети.
    Создаёт сервер, позволяющий обновлять и записывать в редис шеры, учитывая ограничения на кол-во запросов с стороны соцсети
  """
  defmacro __using__(_) do
    quote do
      use GenServer

      alias Viralligator.RedisClient
      alias Viralligator.Handler

      def	init(:ok, server_pid, initial_state) do
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

      def handle_cast({:update_links}, urls) do
        {:noreply, Handler.urls_by_tags}
      end

      def handle_cast({:start_loop}, urls) do
        urls
        |> Enum.map(&RateLimitter.rate_loop(share_function, &1, @rate_limit, 0))
        {:noreply, update_links}
      end

      defp share_function do
        &update_share/1
      end

      defp update_share(url) do
        shares = Handler.shares_by_url(url, @social_name)
        query = ["HSET", "shares:url:#{@social_name}", url, shares.shares.count]
        RedisClient.query(query)
      end
    end
  end
end
