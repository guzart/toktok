describe Toktok::Token do
  let(:config) do
    Toktok::Configuration.new(
      algorithm: 'HS256',
      secret_key: '5ef620dda4ef4ee26b422c98609ca20a'
    )
  end

  let(:jwt) do
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyM30.I3qJQ85nJSF2igrbZAvPFYAtBco_6xz4CKI2bWi3uVI'
  end

  before(:each) do
    instance_double(Toktok)
    allow(Toktok).to receive(:config).and_return(config)
  end

  describe 'encoding' do
    it 'encodes a jwt token when initialized using a subject' do
      token = Toktok::Token.new(subject: 123)
      expect(token.jwt).to eq(jwt)
    end
  end

  describe 'decoding' do
    it 'decodes a jwt token when initialized with a jwt' do
      token = Toktok::Token.new(jwt: jwt)
      expect(token.subject).to eq(123)
    end
  end
end
