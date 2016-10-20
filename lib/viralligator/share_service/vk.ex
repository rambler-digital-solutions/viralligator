defmodule Vk do
  @moduledoc """
  Модуль для получения шаров с vk.com
  """

  use HTTPotion.Base

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
