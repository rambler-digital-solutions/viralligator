defmodule Vk do
  @moduledoc """
  Модуль для получения шаров с vk.com
  """

  use HTTPotion.Base

  def process_url(url) do
    "http://vk.com/share.php?act=count&url=" <> url
  end

  def process_response_body(body) do
    binary_body = body |> IO.iodata_to_binary
    count_shares = Regex.scan(~r/ \d+/, binary_body) 

    count_shares
    |> List.flatten 
    |> Enum.at(0)
    |> String.trim
  end
end
