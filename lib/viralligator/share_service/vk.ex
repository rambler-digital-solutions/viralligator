defmodule Viralligator.ShareService.Vk do
  @moduledoc """
  Модуль для получения шаров с vk.com
  """
  use HTTPotion.{Base, Cache}

  @social_name "Vk"
  @rate_limit 3

  use Viralligator.ShareService.ShareServer

  def process_url(url) do
    "http://vk.com/share.php?act=count&url=" <> url
  end

  def process_response_body(body) do
    body
    |> IO.iodata_to_binary
    |> parse_digit
    |> List.flatten
    |> Enum.at(0)
    |> String.trim
  end

  defp parse_digit(str) do
    Regex.scan(~r/ \d+/, str)
  end
end
