defmodule Viralligator.ShareService do
  @moduledoc """
  Модуль комбинирующий получение шаров с различных соц.сетей
  """
  alias Viralligator.Models.Share

  @folder_for_socials "lib/viralligator/share_service"

  def shares(url), do: list_services |> Enum.map(&wrap_sharing(&1, url))

  def call(mod, url) do
    Module.concat(Viralligator.ShareService, mod)
          .get(url, cache: true)
          .body |> Integer.parse |> elem(0)
  end

  defp wrap_sharing(social, url), do:
    %Share{social: to_string(social), count: call(social, url)}

  defp list_services do
    @folder_for_socials
    |> Path.join("*.ex")
    |> Path.wildcard
    |> Enum.map(&Path.basename(&1, ".ex"))
    |> Enum.map(&String.capitalize/1)
  end
end
