# Toktok

[![Build Status](https://travis-ci.org/guzart/toktok.svg?branch=master)](https://travis-ci.org/guzart/toktok)
[![codecov](https://codecov.io/gh/guzart/toktok/branch/master/graph/badge.svg)](https://codecov.io/gh/guzart/toktok)
[![Code Climate](https://codeclimate.com/github/guzart/toktok/badges/gpa.svg)](https://codeclimate.com/github/guzart/toktok)
[![Gem Version](https://badge.fury.io/rb/toktok.svg)](https://badge.fury.io/rb/toktok)


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
# 'none' | 'HS256' | 'RS256' | 'ES256'
Toktok.algorithm = 'HS256'

# REQUIRED unless algorithm = 'none'
Toktok.secret_key = ENV['TOKTOK_SECRET_KEY'] 

# OPTIONAL – in seconds
Toktok.lifetime = nil 
```

**Encode/Decode**

```ruby
token = Toktok::Token.new(identity: 'guzart', payload: { message: 'Hola' })
puts token.jwt # 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1...'

token = Toktok::Token.new(jwt: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1...')
puts token.identity # 'guzart'
puts token.payload # { sub: 'guzart', message: 'Hola' }
```

## Claims

### Subject Claim

Toktok uses the required `identity` argument as the payload `sub` attribute defined
by the [JWT Subject Claim](https://tools.ietf.org/html/rfc7519#section-4.1.2).

### Expiration Time Claim

Toktok automatically calculates the token expiration using the `Toktok.lifetime` configuration
value and sets the `exp` attribute defined by the
[JWT Expiration Time Claim](https://tools.ietf.org/html/rfc7519#section-4.1.4)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version,
update the version number in `version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/guzart/toktok.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

