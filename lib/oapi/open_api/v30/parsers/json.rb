# frozen_string_literal: true

class OAPI::OpenAPI::V30::Parsers::JSON
  using OAPI::Monkey

  class << self
    def parse(input) = parse_object(input, OAPI::OpenAPI::V30::Definition)

    def parse_type(input, type)
      return input if type.nil?

      return parse_array(input, type) if type <= OAPI::Types::Array

      return parse_map(input, type) if type <= OAPI::Types::Map

      return OAPI::Ref.new(input[:$ref]) if input[:$ref]

      return type.new { input } if type <= OAPI::Schema

      return parse_object(input, type) if type <= OAPI::Types::Object

      raise ArgumentError, "unknown type #{type}"
    end

    def parse_object(input, klass)
      klass.new.tap do |obj|
        klass.properties.each do |name, type|
          value = input[name.camelize]

          obj.send(name, parse_type(value, type)) unless value.nil?
        end
      end
    end

    def parse_array(input, klass) = klass.new(input.map { parse_type(_1, klass.item_type) })
    def parse_map(input, klass) = klass.new(input.transform_values { parse_type(_1, klass.item_type) })
  end
end
