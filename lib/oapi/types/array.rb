# frozen_string_literal: true

class OAPI::Types::Array < OAPI::Types::Object
  attr_reader :store

  def initialize(store = [], &)
    @store = store
    super(&)
  end

  class << self
    attr_reader :item_name, :item_type

    def item(name, type)
      @item_name = name
      @item_type = type

      define_method(name) do |&block|
        @store << type.new(&block)
      end
    end

    def parse(json) = new(json.map { item_type.parse(_1) })
  end
end
