defmodule Viralligator.Handler do
  use GenServer
  alias Viralligator.Models

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge(opts, name: __MODULE__))
  end

  def init(:ok) do
    {:ok, nil}
  end

  def topics_count do
    0
  end

  def topic do
    TopicState.unpublished
  end

  def publish(_) do
    nil
  end
end
