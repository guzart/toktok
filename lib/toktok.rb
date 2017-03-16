module Toktok
  require 'toktok/configuration'
  require 'toktok/token'
  require 'toktok/version'

  def self.algorithm=(value)
    @algorithm = value
  end

  def self.lifetime=(value)
    @lifetime = value
  end

  def self.secret_key=(value)
    @secret_key = value
  end

  def self.config
    ::Toktok::Configuration.new(
      algorithm: @algorithm,
      lifetime: @lifetime,
      secret_key: @secret_key
    )
  end
end
