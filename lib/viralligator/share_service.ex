defmodule Viralligator.ShareService do
  @moduledoc """
  Модуль комбинирующий получение шаров с различных соц.сетей
  """
  alias Viralligator.Models.Share

  def shares(url)  do
    [:ok, :vk, :fb, :gplus]
    |> Enum.map(fn x -> %Share{social: to_string(x), count: call(x, url)} end)
  end

  def call(mod, url) do
    case mod do
      :ok -> Ok.get(url, cache: true).body
      :vk -> Vk.get(url, cache: true).body
      :fb -> Fb.get(url, cache: true).body
      :gplus -> GPlus.get(url, cache: true).body
    end
  end
end