# frozen_string_literal: true

require_relative '../../lib/low_dependency'
require_relative '../fixtures/mock_provider'

RSpec.describe LowDependency do
  describe '.provide' do
    it 'defines a provider' do
      described_class.provide(:mock_provider) do
        MockProvider.new
      end

      expect(Low::Providers.all.count).to eq(1)
    end
  end
end
