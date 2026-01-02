# frozen_string_literal: true

require_relative 'expressions/dependency'
require_relative 'providers'

class LowDependency
  class << self
    def provide(key, &block)
      Low::Providers.provide(key:, &block)
    end

    def providers
      Low::Providers.providers
    end

    def stack
      @stack ||= []
      @stack
    end
  end

  # "include LowDependency[:dependency]"
  def self.[](dependencies)
    item = []

    [*dependencies].each do |var, key|
      key = var if key.nil?
      item << (Low::Dependency.new(var:) | key)
    end

    LowDependency.stack << item

    Module.new do
      def self.included(klass)
        class << klass
          @low_dependencies = LowDependency.stack.pop
        end
      end

      define_method(:initialize) do
        binding.pry
        self.class.low_dependencies.each do |dependency|
          instance_variable_set(dependency.var_name, LowDependency.providers[dependency.key].result)
        end
      end
    end
  end
end
