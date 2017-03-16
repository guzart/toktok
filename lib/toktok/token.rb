require 'jwt'

module Toktok
  InvalidIdentity = Class.new(StandardError)
  InvalidSignature = Class.new(StandardError)

  class Token
    attr_reader :config, :jwt, :payload

    def initialize(identity: nil, jwt: nil, payload: nil)
      @config = Toktok.config
      @payload = {}
      if jwt
        initialize_decode(jwt, identity)
      else
        initialize_encode(identity, payload)
      end
    end

    def identity
      payload[:sub]
    end

    private

    def initialize_encode(identity, extra)
      prepare_payload(identity, extra)
      normalize_payload
      @jwt = JWT.encode(payload, config.secret_key, config.algorithm)
    end

    def initialize_decode(jwt, identity)
      @jwt = jwt
      options = decode_options(identity)
      decoded_token = JWT.decode(jwt, config.secret_key, algorithm?, options)
      @payload = symbolize_keys(decoded_token[0])
      @header = decoded_token[1]
    rescue JWT::InvalidSubError
      raise InvalidIdentity, "Invalid identity. Expected #{identity}"
    rescue JWT::VerificationError
      raise InvalidSignature, 'Invalid or manipulated signature'
    end

    def decode_options(identity)
      options = { algorithm: config.algorithm }
      options = options.merge(sub: identity, verify_sub: true) if identity
      options
    end

    def algorithm?
      config.algorithm != 'none'
    end

    def prepare_payload(identity, extra = nil)
      @payload.merge!(symbolize_keys(extra)) if extra
      @payload[:sub] = identity
      @payload[:exp] = Time.now.to_i + config.lifetime if config.lifetime.to_i > 0
    end

    # Guarantee the order in which the keys are inserted
    def normalize_payload
      @payload = Hash[payload.keys.sort.map { |k| [k, payload[k]] }]
    end

    def symbolize_keys(hash)
      Hash[hash.map { |k, v| [k.to_sym, v] }]
    end
  end
end
