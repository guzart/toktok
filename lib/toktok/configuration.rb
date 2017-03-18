module Toktok
  class Configuration
    attr_reader :algorithm, :lifetime, :secret_key

    # Error raised when an algorithm is given but the secret_key is missing.
    SecretKeyMissingError = Class.new(StandardError)

    def initialize(algorithm: nil, lifetime: nil, secret_key: nil)
      @algorithm = algorithm
      @lifetime = lifetime
      @secret_key = secret_key

      set_defaults
      validate_config
    end

    private

    def set_defaults
      @algorithm ||= 'HS256'
      @secret_key ||= ENV['SECRET_KEY_BASE']
    end

    def validate_config
      if algorithm != 'none' && (secret_key || '') == ''
        raise SecretKeyMissingError, "Toktok: The algorithm #{algorithm} requires you to setup a 'secret_key'"
      end
    end
  end
end
