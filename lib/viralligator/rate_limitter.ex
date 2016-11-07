defmodule RateLimitter do
  @moduledoc """
  Rate limits api
  """

  @doc """
  Запускает callback не более limit раз в секунду.
  count - сколько раз выполнить. По умолчанию бесконечно.
  """
  def rate_loop(callback, limit, count \\ nil) do
    sleeping_time = round(1000 / limit)

    start_time = :os.system_time
    callback.()
    stop_time = :os.system_time

    past_time = (stop_time - start_time) / 100000

    if past_time < sleeping_time, do: :timer.sleep(sleeping_time)

    cond do
      count > 1 -> rate_loop(callback, limit, count - 1)
      is_nil(count) -> rate_loop(callback, limit)
      _ -> :end
    end
  end
end
