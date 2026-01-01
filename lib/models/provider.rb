# frozen_string_literal: true

module Low
  class Provider
    attr_reader :key, :result

    def initialize(key:, &block)
      @key = key
      @proc = block
      @result = nil
    end

    def run
      @result = @proc.call
    end
  end
end
