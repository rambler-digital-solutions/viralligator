defmodule Viralligator.ShareService.Ok do
  @moduledoc """
  Модуль для получения шаров с ok.ru
  """
  use HTTPotion.Base

  @social_name "Ok"
  @rate_limit 5

  use Viralligator.ShareService.ShareServer

  def process_url(url) do
    "https://connect.ok.ru/dk?st.cmd=extLike&uid=odklcnt0&ref=" <> url
  end

  def process_response_body(body) do
    body
    |> IO.iodata_to_binary
    |> parse_digit
    |> List.flatten
    |> List.last
  end

  defp parse_digit(str) do
    Regex.scan(~r/,\'(\d+)/, str)
  end
end
