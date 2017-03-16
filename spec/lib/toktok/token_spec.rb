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

  describe 'encoding' do
    it 'encodes a jwt token when initialized using an identity' do
      prepare_config
      token = Toktok::Token.new(identity: 123)
      expect(token.jwt).to eq(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
      )
    end

    it 'uses the identity for the Subject claim' do
      prepare_config
      token = Toktok::Token.new(identity: 123)
      expect(token.payload['sub']).to eq(123)
    end
  end

  describe 'decoding' do
    describe 'when initialized with a jwt' do
      it 'decodes a jwt token' do
        prepare_config
        jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
        token = Toktok::Token.new(jwt: jwt)
        expect(token.identity).to eq(123)
      end
    end

    describe 'when initialized with a jwt and a subject' do
      it 'verifies the Subject claim when initialized with a :jwt and a :subject' do
        prepare_config
        jwt = JWT.encode({ sub: 345 }, secret_key, algorithm)
        expect { Toktok::Token.new(jwt: jwt, identity: 123) }.to raise_error(Toktok::InvalidIdentity)
      end
    end

    describe 'without an algorithm' do
      it 'decodes a jwt token' do
        prepare_config(algorithm: 'none')
        jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.'
        token = Toktok::Token.new(jwt: jwt)
        expect(token.identity).to eq(123)
      end
    end

    # it 'verifies the Subject claim' do
    #   real_signature = 'I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
    #   highjacked_jwt = JWT.encode({ sub: 345 }, secret_key, algorithm)
    #   # other_header_payload = .split('.').take(2)
    #   # highjacked_jwt = other_header_payload.concat([real_signature]).join('.')
    #   # highjacked_jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
    #   token = Toktok::Token.new(jwt: highjacked_jwt)
    # end
  end
end
