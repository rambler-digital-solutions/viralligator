defmodule Viralligator.Handler do
  @moduledoc """
    Handlers
  """

  use GenServer
  use Amnesia

  alias Viralligator.Models.Topic

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge(opts, name: __MODULE__))
  end

  def init(:ok) do
    Amnesia.start

    {:ok, nil}
  end

  def topics_count do
    Amnesia.transaction do
      Database.Topic.count
    end
  end

  def topic(url) do
    binary_url = url |> IO.iodata_to_binary
    
    topic_map = Amnesia.transaction do
      %Database.Topic{ url: binary_url } 
      |> Database.Topic.write
      |> Map.from_struct
    end 
    
    struct(%Topic{}, topic_map)
  end

  def publish(_) do
    nil
  end

   def handle_error(b, a) do
     IO.puts b
     IO.puts a
     IO.puts "ERrrorrr rererer!!!"
   end
end
