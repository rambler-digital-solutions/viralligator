defmodule HTTPotion.Cache do
  @moduledoc """
  HTTPotion Cache implementation
  """

  defmacro __using__(_) do
    quote do
      @doc """
      Override HTTPotion.request method
      """
      def request(method, url, options \\ []) do
        case Keyword.get(options, :cache, false) do
          false -> super(method, url, options)
          true -> request_from_cache(method, url, options)
        end
      end

      defp request_from_cache(method, url, options \\ []) do
        # Cachex.start_link(:http_cache, [])
        case Cachex.get(:http_cache, cache_key(method, url)) do
          {:ok, response} -> response
          {:missing, _} -> cache_request(method, url, options)
          _ -> request(method, url, Keyword.delete(options, :cache))
        end
      end

      defp cache_request(method, url, options \\ []) do
        # Cachex.start_link(:http_cache, [])
        response = request(method, url, Keyword.delete(options, :cache))
        Cachex.set(:http_cache, cache_key(method, url), response)
        response
      end

      defp cache_key(method, url) do
        Enum.join([method, process_url(url)], " ")
      end
    end
  end
end
