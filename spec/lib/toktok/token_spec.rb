require 'spec_helper'

describe Toktok::Token do
  let(:algorithm) { 'HS256' }
  let(:secret_key) { '5ef620dda4ef4ee26b422c98609ca20a' }

  def prepare_config(**args)
    attrs = { algorithm: algorithm, secret_key: secret_key }.merge(args)
    config = Toktok::Configuration.new(**attrs)

    instance_double(Toktok)
    allow(Toktok).to receive(:config).and_return(config)
  end

  context 'when initialized with :identity' do
    it 'encodes a jwt token' do
      prepare_config
      token = Toktok::Token.new(identity: 123)
      expect(token.jwt).to eq(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
      )
    end

    it 'uses the identity for the Subject claim' do
      prepare_config
      token = Toktok::Token.new(identity: 123)
      expect(token.payload[:sub]).to eq(123)
    end

    context 'and initialized with :payload' do
      it 'merges the given payload' do
        prepare_config
        token = Toktok::Token.new(identity: 123, payload: { message: 'Hello!' })
        expect(token.payload[:message]).to eq('Hello!')
        expect(token.jwt).to eq([
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9',
          'eyJtZXNzYWdlIjoiSGVsbG8hIiwic3ViIjoxMjN9',
          'TriotdATTT_ZcJ8-GRB7gPVIXjcRPhh510z_8-uP67g'
        ].join('.'))
      end

      it 'normalizes the payload to guarantee token equality' do
        prepare_config
        p = { message: 'Hello!' }
        p1 = p.merge(title: 'Greeting')
        p2 = { title: 'Greeting' }.merge(p)
        token1 = Toktok::Token.new(identity: 123, payload: p1)
        token2 = Toktok::Token.new(identity: 123, payload: p2)
        expect(token1.jwt).to eq(token2.jwt)
      end
    end

    context 'with a lifetime configuration' do
      it 'sets the Expiration Time claim' do
        prepare_config(lifetime: 3_600)
        time = Time.local(2008, 9, 1, 10, 5)
        Timecop.freeze(time) do
          token = Toktok::Token.new(identity: 123)
          expect(token.payload[:exp]).to eq(time.to_i + 3_600)
        end
      end
    end
  end

  context 'when initialized with :jwt' do
    it 'decodes the jwt token' do
      prepare_config
      jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
      token = Toktok::Token.new(jwt: jwt)
      expect(token.identity).to eq(123)
    end

    context 'and initialized an :identity' do
      it 'validates the Subject claim' do
        prepare_config
        jwt = JWT.encode({ sub: 345 }, secret_key, algorithm)
        expect { Toktok::Token.new(jwt: jwt, identity: 123) }.to raise_error(Toktok::InvalidIdentity)
      end
    end

    it 'validates the signature' do
      prepare_config
      original_jwt = JWT.encode({ sub: 123 }, secret_key, algorithm)
      other_jwt = JWT.encode({ sub: 345 }, secret_key, algorithm)
      manipulated_jwt = apply_signature(other_jwt, find_signature(original_jwt))
      expect { Toktok::Token.new(jwt: manipulated_jwt) }.to raise_error(Toktok::InvalidSignature)
    end

    context 'without an algorithm' do
      it 'decodes the jwt token' do
        prepare_config(algorithm: 'none')
        jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.'
        token = Toktok::Token.new(jwt: jwt)
        expect(token.identity).to eq(123)
      end
    end
  end
end
