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

  test "shares for rns not empty" do
    Handler.publish "https://rns.online"
    assert (Handler.sharings |> length) != 0
  end
end
