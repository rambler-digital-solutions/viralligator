# Viralligator

Content monitoring

## Installation

- `mix deps.get`
- `mix amnesia.create -db Database --disk`

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
$:.push('gen-rb')
require 'thrift'
require 'viralligator'

transport = Thrift::FramedTransport.new(Thrift::Socket.new('127.0.0.1', port))
protocol = Thrift::BinaryProtocol.new(transport)
client = Viralligator::Client.new(protocol)

transport.open
client.sharings
```
