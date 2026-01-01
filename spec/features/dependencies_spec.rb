# frozen_string_literal: true

require_relative '../../lib/low_dependency'
require_relative '../fixtures/mock_provider'

class IncludeDependency
  include LowDependency[:mock_provider]
end

RSpec.describe 'dependencies' do
  before do
    LowDependency.provide(:mock_provider) do
      MockProvider.new
    end
  end

  describe 'include LowDependency[:dependency]' do
    let(:subject) { IncludeDependency.new }

    it 'instantiates with dependency' do
      expect(subject.mock_provider).to be_instance_of(MockProvider)
    end
  end

  # describe 'def method(dependency: Dependency)' do
  # end
end
