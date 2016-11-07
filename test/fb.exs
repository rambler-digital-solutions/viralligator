defmodule Viralligator.FbTest do
  use ExUnit.Case
  doctest Viralligator.ShareService.Fb
  alias Viralligator.ShareService.Fb
  alias Viralligator.RedisClient
  alias Viralligator.Handler

  test "get_links" do
    Fb.start_link
    assert GenServer.call(Fb, {:get_links}) == ["http://secretmag.ru/articles/2015/09/30/yo", "http://secretmag.ru/articles/2015/09/30/pensii/", "https://rns.online"]
  end

  test "update_shares" do
    assert Fb.start_loop == []
  end
end
