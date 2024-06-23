# frozen_string_literal: true

class OAPI::Schema
  attr_reader :schema

  def initialize
    @schema = yield if block_given?
  end

  class << self
    def parse(json)
      ref = json[:$ref]
      return OAPI::Ref.new(ref) if ref

      new { json }
    end
  end
end
