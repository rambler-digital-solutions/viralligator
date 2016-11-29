defmodule Viralligator.CacherDecorator do
  @moduledoc false

  use Decorator.Define, [cache: 1]
  alias Viralligator.CacherDecorator

  @doc """
  Макрос для кеширования ф-ций. Использовать: `@decorator cache(time)`
  """
  def cache(time, body, %{args: [mod, context]}) do
    quote do
      cache_key = unquote(mod) <> unquote(context)

      case Cachex.get(:http_cache, cache_key) do
        {:ok, response} -> response

        {:missing, _} ->
          CacherDecorator.cache_body(cache_key, unquote(body), unquote(time))

        _ -> unquote(body)
      end
    end
  end

  def cache_body(key, body, time) do
    Cachex.set(:http_cache, key, body, [ttl: time])
    body
  end
end
