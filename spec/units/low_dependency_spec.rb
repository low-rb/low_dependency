# frozen_string_literal: true

require_relative '../../lib/low_dependency'
require_relative '../fixtures/mock_provider'

RSpec.describe LowDependency do
  before do
    # Low::Providers.clear
    # Object.send(:remove_const, 'MockProvider')
    # load 'spec/fixtures/mock_provider.rb'
  end

  describe '.provide' do
    it 'defines a provider' do
      described_class.provide(:mock_provider) do
        MockProvider.new
      end

      expect(described_class.providers.count).to eq(1)
    end
  end
end
