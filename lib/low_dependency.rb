# frozen_string_literal: true

require_relative 'providers'

class LowDependency
  class << self
    def provide(key, &block)
      Low::Providers.provide(key:, &block)
    end

    def providers
      Low::Providers.providers
    end
  end
end
