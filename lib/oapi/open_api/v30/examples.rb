# frozen_string_literal: true

class OAPI::OpenAPI::V30::Examples < OAPI::Types::Map
  class Example < OAPI::Types::Object
    property :summary
    property :description
    property :value
    property :external_value
  end

  item :example, Example
end
