# frozen_string_literal: true

class OAPI::Types::Map < OAPI::Types::Object
  attr_reader :store

  def initialize(store = {}, &)
    @store = store
    super(&)
  end

  class << self
    attr_reader :item_name, :item_type

    def item(name, type = nil)
      @item_name = name
      @item_type = type

      define_method(name) do |key, &block|
        raise ArgumentError, "'#{key}' already exists" if @store.include?(key.to_s)

        @store[key] = type.new(&block)
      end
    end

    def parse(json)
      store = json.transform_values do |value|
        item_type ? item_type.parse(value) : value
      end
      new(store)
    end
  end
end
