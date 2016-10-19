defmodule Vk do
  use HTTPotion.{Base, Cache}

  def process_url(url) do
    "http://vk.com/share.php?act=count&url=" <> url
  end

  def process_response_body(body) do
    binary_body = body |> IO.iodata_to_binary
    Regex.scan(~r/ \d+/, binary_body)
    |> List.flatten
    |> Enum.at(0)
    |> String.trim
  end
end
