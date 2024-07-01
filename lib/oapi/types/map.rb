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

      define_method(name) do |key, ref: nil, &block|
        raise ArgumentError, "'#{key}' already exists" if @store.include?(key.to_s)

        raise ArgumentError, "ref and block are mutual exclusive" if ref && block

        return @store[key] = OAPI::Ref.new(ref) if ref

        @store[key] = type.new(&block)
      end
    end
  end
end
