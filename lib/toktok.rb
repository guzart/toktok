module Toktok
  require 'toktok/configuration'
  require 'toktok/token'
  require 'toktok/version'

  # Set the algorithm used to encode and decode JWT tokens (default: HS256)
  #
  # Acceptable values are:
  # * none
  # * HS256, HS384, HS512
  # * RS256, RS384, RS512
  # * ES256, ES384, ES512
  #
  # @param [String] value the algorithm name
  # @return [String] the algorithm
  def self.algorithm=(value)
    @algorithm = value
  end

  # Set the lifetime in seconds before a token expires (default: nil)
  #
  # @param [Integer, nil] value the number of seconds before a token expires
  # @return [Integer, nil] the lifetime
  def self.lifetime=(value)
    @lifetime = value
  end

  # Set the secret key that will be used to encode and decode JWT tokens
  # @param [String] value the secret key
  # @return [String] the secret key
  def self.secret_key=(value)
    @secret_key = value
  end

  # Gets a Toktok::Configuration instance using the module values.
  #
  # @return [Toktok::Configuration] the configuration
  def self.config
    ::Toktok::Configuration.new(
      algorithm: @algorithm,
      lifetime: @lifetime,
      secret_key: @secret_key
    )
  end
end
