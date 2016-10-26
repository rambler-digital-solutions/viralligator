# Viralligator

client for Viralligator service

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'viralligator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install viralligator

## Usage

```ruby
Viralligator.client.topicsCount
```

## Methods

**TBD**

## Configuration

```ruby
Viralligator::Configuration.config do |config|
  config.dsn='//s1.viralligator.rns.online:2112'
end
```

## Testing in console

```
bundle console
x = Viralligator::Adapter.new
x.open_connect
x.client.topicsCount
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/viralligator.
