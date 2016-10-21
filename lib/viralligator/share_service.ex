defmodule Viralligator.ShareService do
  @moduledoc """
  Модуль комбинирующий получение шаров с различных соц.сетей
  """
  alias Viralligator.Models.Share

  @folder_for_socials "lib/viralligator/share_service"

  def shares(url)  do
    list_services
    |> Enum.map(fn x -> %Share{social: to_string(x), count: call(x, url)} end)
  end

  def call(mod, url) do
    Module.concat(Viralligator.ShareService, mod)
          .get(url, cache: true)
          .body
  end

  defp list_services do
    @folder_for_socials
    |> Path.join("*.ex")
    |> Path.wildcard
    |> Enum.map(fn item -> Path.basename(item, ".ex") end)
    |> Enum.map(&String.capitalize/1)
  end
end
