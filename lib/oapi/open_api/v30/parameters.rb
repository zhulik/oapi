# frozen_string_literal: true

class OAPI::OpenAPI::V30::Parameters < OAPI::Types::Array
  class Parameter < OAPI::Types::Object
    property :name
    property :_in
    property :description
    property :required
    property :deprecated

    property :style
    property :explode
    property :allow_reserved
    property :example

    property :examples, OAPI::OpenAPI::V30::Examples

    property :schema, OAPI::Schema
  end

  item :parameter, Parameter
end
