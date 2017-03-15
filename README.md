# Toktok

[![Build Status](https://travis-ci.org/guzart/toktok.svg?branch=master)](https://travis-ci.org/guzart/toktok)
[![codecov](https://codecov.io/gh/guzart/toktok/branch/master/graph/badge.svg)](https://codecov.io/gh/guzart/toktok)


JWT Authentication for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'toktok'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install toktok

## Usage

TODO: Improve

**Configuration**

```ruby
Toktok.algorithm = 'HS256'
Toktok.secret_key = ENV['MY_SECRET_KEY']
```

**Encode/Decode**

```ruby
token = Toktok::Token.new(identity: 'guzart')
puts token.jwt # 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1...'

token = Toktok::Token.new(jwt: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1...')
puts token.identity # 'guzart'
puts token.payload # { sub: 'guzart' }
```

## API

TODO: list public api

### ::Toktok

### ::Toktok::Token

## Claims

TODO: describe relation in configuration and in token payload

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/guzart/toktok.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

