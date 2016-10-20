defmodule HTTPotion.CacheTest do
  use ExUnit.Case, async: true
  doctest HTTPotion

  test "request creates key" do
    defmodule TestClient do
      use HTTPotion.{Base, Cache}
    end

    Cachex.start_link(:http_cache, [default_ttl: :timer.seconds(10)])

    response = TestClient.get("httpbin.org/get", cache: true)
    {:ok, cached_response} = Cachex.get(:http_cache, "get httpbin.org/get")
    assert response == cached_response
  end
end
