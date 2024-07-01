# frozen_string_literal: true

class OAPI::Schema
  attr_reader :schema

  def initialize
    @schema = yield if block_given?
  end
end
