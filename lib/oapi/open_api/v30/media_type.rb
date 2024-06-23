# frozen_string_literal: true

class OAPI::OpenAPI::V30::MediaType < OAPI::Types::Object
  class Encoding < OAPI::Types::Map
    class EncodingItem < OAPI::Types::Object
      property :content_type
      property :style
      property :explode
      property :allow_reserverd

      property :headers, OAPI::OpenAPI::V30::Headers
    end

    item :encoding, EncodingItem
  end

  property :example

  property :examples, OAPI::OpenAPI::V30::Examples
  property :encoding, Encoding
  property :schema, OAPI::Schema
end
