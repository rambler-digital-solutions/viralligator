defmodule Ok do
  use HTTPotion.Base

  def process_url(url) do
    "https://connect.ok.ru/dk?st.cmd=extLike&uid=odklcnt0&ref=" <> url
  end

  def process_response_body(body) do
    binary_body = body |> IO.iodata_to_binary
    Regex.scan(~r/,\'(\d+)/, binary_body)
    |> List.flatten
    |> List.last
  end
end
