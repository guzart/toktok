module Toktok
  class Token
    attr_reader :config, :jwt, :payload

    def initialize(subject: nil, jwt: nil, algorithm: nil)
      @config = Toktok.config

      if jwt.nil? && !subject.nil?
        @jwt = JWT.encode({ sub: subject }, config.secret_key, config.algorithm)
      elsif subject.nil? && !jwt.nil?
        @jwt = jwt
        decoded_token = JWT.decode(jwt, nil, false)
        @payload = decoded_token[0]
        # @header = decoded_token[1]
      end
    end

    def subject
      @payload['sub']
    end
  end
end
