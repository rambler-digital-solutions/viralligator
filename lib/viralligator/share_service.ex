defmodule Viralligator.ShareService do
  def shares(url)  do
    [Ok, Vk, Fb, GPlus]
    |> Enum.map(fn x -> { x, x.get(url).body } end)
    |> Enum.into(%{})
  end
end
