# frozen_string_literal: true

require_relative '../expressions/dependency'

module Low
  class DependencyFactory
    include LowType

    class << self
      def parse(dependencies = Array)
        class_dependencies = []

        dependencies.each do |dependency|
          case dependency
          when Hash
            key = dependency.keys.first
            dependency = dependency[key]
          else
            key = dependency
          end

          class_dependencies << (Dependency.new(var: dependency) | key)
        end

        class_dependencies
      end
    end
  end
end
