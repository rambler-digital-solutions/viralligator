defmodule Viralligator.ShareService do
  def shares(url)  do
    [:ok, :vk, :fb, :gplus]
    |> Enum.map(fn x -> { to_string(x), call(x, url) } end)
    |> Enum.into(%{})
  end

  def call(mod, url) do
    case mod do
      :ok -> Ok.get(url).body
      :vk -> Vk.get(url).body
      :fb -> Fb.get(url).body
      :gplus -> GPlus.get(url).body
    end
  end
end
