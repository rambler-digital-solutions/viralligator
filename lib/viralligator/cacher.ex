defmodule Viralligator.CacherDecorator do
  use Decorator.Define, [cache: 1]

  def cache(time, body, %{args: [mod, context]}) do
    quote do
      IO.inspect(context)
      unquote(
        case Cachex.get(:http_cache, context) do
          {:ok, response} -> response
          {:missing, _} -> body
      end)
    end
  end
end
