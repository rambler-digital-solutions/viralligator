defmodule Viralligator.Handler do
  @moduledoc """
    Handlers
  """

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

  def topic(url) do
    %Viralligator.Models.Topic{ id: "id", url: url } |> Topic.write
  end

  def publish(_) do
    nil
  end

   def handle_error(_, _) do
     IO.puts "ERrrorrr rererer!!!"
   end
end
