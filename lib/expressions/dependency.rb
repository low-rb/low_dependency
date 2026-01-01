# frozen_string_literal: true

require 'expressions'

module Low
  class Dependency < Expressions::Expression
    attr_reader :key, :var_name

    def initialize(var_name:)
      super()

      @key = var_name
      @var_name = var_name
    end

    private

    def receive_value(value)
      @key = value
    end
  end
end
