# frozen_string_literal: true

require_relative '../../lib/low_dependency'
require_relative '../fixtures/mock_dependencies'
require_relative '../fixtures/mock_provider'

RSpec.describe 'include LowDependency[:dependency]' do
  after do
    LowDependency.providers.clear
  end

  context 'with a single dependency' do
    let(:subject) { IncludeDependency.new }

    before { LowDependency.provide(:provider_one) { MockProvider.new } }

    it 'injects dependency' do
      expect(subject.provider_one).to be_instance_of(MockProvider)
    end

    context 'with a string key dependency' do
      let(:subject) { IncludeStringDependency.new }

      before { LowDependency.provide('provider_one') { MockProvider.new } }

      it 'injects dependency' do
        expect(subject.provider_one).to be_instance_of(MockProvider)
      end
    end
  end

  context 'with multiple dependencies' do
    let(:subject) { IncludeDependencies.new }

    before do
      LowDependency.provide(:provider_one) { MockProvider.new }
      LowDependency.provide(:provider_two) { MockProvider.new }
    end

    it 'injects multiple dependencies' do
      expect(subject.provider_one).to be_instance_of(MockProvider)
      expect(subject.provider_two).to be_instance_of(MockProvider)
    end

    context 'with string key dependencies' do
      let(:subject) { IncludeStringDependencies.new }

      before do
        LowDependency.provide('provider_one') { MockProvider.new }
        LowDependency.provide('provider_two') { MockProvider.new }
      end

      it 'injects dependencies' do
        expect(subject.provider_one).to be_instance_of(MockProvider)
        expect(subject.provider_two).to be_instance_of(MockProvider)
      end
    end
  end
end
