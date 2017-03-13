RSpec.describe Toktok::Configuration do
  let(:secret_key) { 'f6bfddc1fabf88dc01a93f0d85f8b16d' }
  let(:config) { Toktok::Configuration.new(secret_key: secret_key) }

  it 'defaults to a "HS256" algorithm' do
    expect(config.algorithm).to eq('HS256')
  end

  it 'can be initialized with an algorithm' do
    config = Toktok::Configuration.new(algorithm: 'HS512', secret_key: secret_key)
    expect(config.algorithm).to eq('HS512')
  end

  it 'can be initialized using a secret_key' do
    config = Toktok::Configuration.new(secret_key: 'abcdef')
    expect(config.secret_key).to eq('abcdef')
  end

  describe 'with an :algorithm but no :secret_key' do
    it 'does not raises an error if the algorithm is "none" ' do
      action = -> { Toktok::Configuration.new(algorithm: 'none', secret_key: '') }
      expect(action).not_to raise_error
    end

    it 'raises an error if the algorithm is something other than "none"' do
      action = -> { Toktok::Configuration.new(algorithm: 'HS256', secret_key: '') }
      expect(action).to raise_error(Toktok::Configuration::SecretKeyMissingError)
    end
  end
end
