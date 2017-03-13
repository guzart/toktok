module Toktok
  class Configuration
    attr_reader :algorithm, :secret_key

    SecretKeyMissingError = Class.new(StandardError)

    def initialize(algorithm: nil, secret_key: nil)
      @algorithm = algorithm || 'HS256'
      @secret_key = secret_key

      if algorithm != 'none' && (secret_key || '') == ''
        raise SecretKeyMissingError, "Toktok: The algorithm #{algorithm} requires you to setup a 'secret_key'"
      end
    end
  end
end
