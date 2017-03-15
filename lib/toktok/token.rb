module Toktok
  InvalidIdentity = Class.new(StandardError)

  class Token
    attr_reader :config, :jwt, :payload

    def initialize(identity: nil, jwt: nil)
      @config = Toktok.config
      @payload = {}
      if jwt
        initialize_decode(jwt, identity)
      else
        initialize_encode(identity)
      end
    end

    def identity
      payload['sub']
    end

    private

    def initialize_encode(identity)
      @payload['sub'] = identity
      @jwt = JWT.encode(payload, config.secret_key, config.algorithm)
    end

    def initialize_decode(jwt, identity)
      @jwt = jwt
      options = decode_options(identity)
      decoded_token = JWT.decode(jwt, config.secret_key, algorithm?, options)
      @payload = decoded_token[0]
      @header = decoded_token[1]
    rescue JWT::InvalidSubError
      raise InvalidIdentity, "Invalid identity. Expected #{identity}"
    end

    def decode_options(identity)
      options = { algorithm: config.algorithm }
      options = options.merge(sub: identity, verify_sub: true) if identity
      options
    end

    def algorithm?
      config.algorithm != 'none'
    end
  end
end
