defmodule Viralligator.ShareServiceTest do
  use ExUnit.Case
  doctest Viralligator.ShareService
  alias Viralligator.ShareService
  alias Viralligator.Handler
  alias Viralligator.RedisClient
  test "something" do
    RedisClient.start_link
    Handler.start_link
    Handler.publish("http://secretmag.ru/articles/2015/09/30/pensii/")
    # IO.inspect RedisClient.query(["GET", "viralligator:tags:viralligator"])
  end

  test "shares for rns not empty" do
    assert ShareService.shares("http://secretmag.ru/articles/2015/09/30/pensii/") ==
      [%Viralligator.Models.Share{count: 2, social: "Ok"},
       %Viralligator.Models.Share{count: 5, social: "Vk"},
       %Viralligator.Models.Share{count: 0, social: "Gplus"},
       %Viralligator.Models.Share{count: 28, social: "Fb"}]
  end

end
