defmodule Viralligator.ShareService do
  def shares(url)  do
    [:ok, :vk, :fb, :gplus]
    |> Enum.map(fn x -> { x, count(url, x) } end)
    |> Enum.into(%{})
  end

  def count(url, :ok) do
    Ok.get(url).body
  end

  def count(url, :vk) do
    Vk.get(url).body
  end

  def count(url, :fb) do
    Fb.get(url).body
  end

  def count(url, :gplus) do
    GPlus.get(url).body
  end
end
