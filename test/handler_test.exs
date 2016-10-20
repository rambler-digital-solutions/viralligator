defmodule Viralligator.HandlerTest do
  use ExUnit.Case
  doctest Viralligator.Handler
  alias Viralligator.Handler

  @tag :skip
  test "topics_count"
  @tag :skip
  test "topic"
  @tag :skip
  test "handle_error"

  test "Check struct type return shares_for_url" do
    assert %Viralligator.Models.Sharing{} = Handler.shares_for_url("http://google.ru")
  end
end
