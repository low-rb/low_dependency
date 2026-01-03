# frozen_string_literal: true

require 'low_type'
require_relative 'expressions/dependency'
require_relative 'factories/dependency_factory'
require_relative 'repositories/dependencies'
require_relative 'repositories/providers'

class LowDependency
  class << self
    def provide(key, &block)
      Low::Providers.provide(key:, &block)
    end

    # "include LowDependency[:dependency]"
    def [](*dependencies)
      class_dependencies = Low::DependencyFactory.parse([*dependencies])

      # "include" doesn't know the class that did the include, however "included" happens immediately after.
      Low::Dependencies.push(class_dependencies:)

      included_hook
    end

    def included_hook
      Module.new do
        def self.included(klass)
          klass.class_eval do
            # "include" doesn't know the class that did the include, however "included" happens immediately after.
            @low_dependencies = Low::Dependencies.pop

            class << self
              attr_reader :low_dependencies
            end

            def initialize
              self.class.low_dependencies.each do |dependency|
                provider = Low::Providers.find(dependency.key)
                raise StandardError, "Provider #{dependency.key} not found" if provider.nil?

                var = LowDependency.provider_from_namespace(dependency.var)
                instance_variable_set("@#{var}", provider.result)
              end
            end

            LowDependency.define_readers(@low_dependencies, self)
          end
        end
      end
    end

    def define_readers(dependencies, klass)
      dependencies.each do |dependency|
        var = provider_from_namespace(dependency.var)

        klass.define_method(var) do
          instance_variable_get("@#{var}")
        end
      end
    end

    def provider_from_namespace(namespace)
      return namespace.split('.').last if namespace.is_a?(String)

      namespace
    end
  end
end
