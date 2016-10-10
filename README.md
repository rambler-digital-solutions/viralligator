# Viralligator

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `viralligator` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:viralligator, "~> 0.1.0"}]
    end
    ```

  2. Ensure `viralligator` is started before your application:

    ```elixir
    def application do
      [applications: [:viralligator]]
    end
    ```

## Thrift Schemas

Code genaration for Viralligator Server and Client Libs  

## Project structure 
  - thrift schemas in `thrift` folder
  - elixir generated code in `src`
  - ruby generated code in `gen-rb`

## Elixir Server Code 
  - `mix deps.get`
  - `mix`

All generated elixir sources should be in `src` direcotry 

## Ruby Client Code
`thrift -r --gen rb thrift/viralligator_service.thrift`

```ruby
transport = Thrift::FramedTransport.new(Thrift::Socket.new('127.0.0.1', port))
protocol = Thrift::BinaryProtocol.new(transport)
client = Viralligator::Client.new(protocol)

transport.open
client.topicsCount
```
