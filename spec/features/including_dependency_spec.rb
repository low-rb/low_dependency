# frozen_string_literal: true

require_relative '../../lib/dependency'
require_relative '../fixtures/mock_provider'

RSpec.describe 'including a dependency' do
  before do
    LowDependency.provide(:mock_provider) do
      MockProvider.new
    end
  end

  describe 'include LowDependency[:dependency]' do
    it 'creates an provider' do

      expect(described_class.providers[:mock_provider].count).to eq(1)
    end
  end

  # describe 'def method(dependency: Dependency)' do
  # end
end
