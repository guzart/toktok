require 'spec_helper'

RSpec.describe Toktok do
  before(:each) { instance_double(Toktok::Configuration) }

  it 'has a version number' do
    expect(::Toktok::VERSION).not_to be_nil
  end

  describe '#config' do
    it 'returns a Toktok::Configuration' do
      ::Toktok.secret_key = '84f613afb98ac163dfe8a5b3b6586da0'
      expect(::Toktok.config).to be_a(::Toktok::Configuration)
    end

    it 'forwards #secret_key to configuration' do
      ::Toktok.secret_key = '84f613afb98ac163dfe8a5b3b6586da0'
      expect(Toktok::Configuration).to receive(:new).with(hash_including(secret_key: '84f613afb98ac163dfe8a5b3b6586da0'))
      ::Toktok.config
    end

    it 'forwards #algorithm to configuration' do
      ::Toktok.algorithm = 'RS384'
      expect(Toktok::Configuration).to receive(:new).with(hash_including(algorithm: 'RS384'))
      ::Toktok.config
    end
  end
end
