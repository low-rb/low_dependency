# frozen_string_literal: true

require 'expressions'

module Low
  class Dependency < Expressions::Expression
    attr_reader :key, :var

    def initialize(var:)
      super()

      @key = var
      @var = var
    end

    private

    def receive_value(value)
      @key = value
    end
  end
end
