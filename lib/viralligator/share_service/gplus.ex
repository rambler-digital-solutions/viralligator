defmodule Viralligator.ShareService.Gplus do
  @moduledoc """
  Модуль для получения шаров с plus.google.com
  """
  use HTTPotion.{Base, Cache}

  @social_name "Gplus"
  @rate_limit 5

  require Viralligator.ShareServer
  Viralligator.ShareServer.add_social_server


  def process_url(url) do
    "https://plusone.google.com/_/+1/fastbutton?url=" <> url
  end

  def process_response_body(body) do
    body
    |> IO.iodata_to_binary
    |> Floki.find("#aggregateCount")
    |> Floki.text
  end
end
