# frozen_string_literal: true

require_relative 'models/provider'

module Low
  class Providers
    class << self      
      def provide(key:, &block)
        providers[key] = Provider.new(key:, &block)
      end
      
      def providers
        @providers ||= {}
        @providers
      end

      def clear
        @providers = {}
      end
    end
  end
end
