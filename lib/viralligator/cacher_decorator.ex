defmodule Viralligator.CacherDecorator do
  @moduledoc false

  use Decorator.Define, [cache: 1]

  @doc """
  Макрос для кеширования ф-ций. Использовать: `@decorator cache(time)`
  """
  def cache(time, body, %{args: [mod, context]}) do
    quote do
      cache_key = unquote(mod) <> unquote(context)

      case Cachex.get(:http_cache, cache_key) do
        {:ok, response} -> response

        {:missing, _} ->
          response = unquote(body)
          Cachex.set(:http_cache, unquote(context), response, [ttl: unquote(time)])
          response

        _ -> unquote(body)
      end
    end
  end
end
