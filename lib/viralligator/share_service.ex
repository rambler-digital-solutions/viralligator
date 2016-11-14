defmodule Viralligator.ShareService do
  @moduledoc """
  Модуль комбинирующий получение шаров с различных соц.сетей
  """
  alias Viralligator.Models.Share

  def shares(url), do: list_services |> Enum.map(&wrap_sharing(&1, url))
  def shares(url, service), do: wrap_sharing(service, url)

  def call(mod, url) do
    social_module(mod)
      .get(url, cache: true)
      .body |> Integer.parse |> elem(0)
  end

  def social_module(mod) do
    Module.concat(Viralligator.ShareService, mod)
  end

  defp wrap_sharing(social, url), do:
    %Share{social: to_string(social), count: call(social, url)}

  def list_services do
    ["Ok", "Vk", "Gplus", "Fb"]
  end
end
