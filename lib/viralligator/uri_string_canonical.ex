defprotocol UriStringCanonical do
  @doc "Метод для приведения урла к каноникал виду"
  def canonical(string)

  def binary_canonical(string)
end

defimpl UriStringCanonical, for: BitString do
  def canonical(string)  do
    string
    |> URI.parse
    |> Map.put(:query, nil)
    |> URI.to_string
  end

  def binary_canonical(url) do
    url |> IO.iodata_to_binary |> canonical
  end
end
