module Toktok
  class Configuration
    attr_reader :algorithm, :lifetime, :secret_key

    # Error raised when an algorithm is given but the secret_key is missing.
    SecretKeyMissingError = Class.new(StandardError)

    def initialize(algorithm: nil, lifetime: nil, secret_key: nil)
      @algorithm = algorithm || 'HS256'
      @lifetime = lifetime
      @secret_key = secret_key

      if algorithm != 'none' && (secret_key || '') == ''
        raise SecretKeyMissingError, "Toktok: The algorithm #{algorithm} requires you to setup a 'secret_key'"
      end
    end
  end
end
