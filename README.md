# Viralligator

Content monitoring

## Installation

First, add Viralligator to your `mix.exs` dependencies:

```elixir
def deps do
  [{:Viralligator, "~> 1.1.0"}]
end
```

and run `$ mix deps.get`. Now, list the `:viralligator` application as your
application dependency:

```elixir
def application do
  [applications: [:viralligator]]
end
```

## Configuration
In your applications config.exs file you need to add new section for customizing viralligator settings:
```elixir
config :viralligator,
  redis_url: "127.0.0.1"
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

## Generate docs
  - `mix docs`

All generated elixir sources should be in `src` direcotry

## Ruby Client Code

Require ruby client in project

```ruby
# Add to gemfile
gem 'viralligator', source: 'http://ramblergems.park.rambler.ru'
```

Use ruby client library locally

```ruby
cd ruby_client && bundle && bundle console
Viralligator.client.topicsCount
```

### Update ruby client

Build ruby client library

`thrift -r -out ruby_client/lib/viralligator --gen rb thrift/viralligator.thrift`


### Update gem version

Update `VERSION` file

`echo "<new_version>" > VERSION`

Build gem

`cd ruby_client && rake build`

Publish gem

`gem inabox ruby_client/pkg/viralligator-$(cat VERSION).gem`
