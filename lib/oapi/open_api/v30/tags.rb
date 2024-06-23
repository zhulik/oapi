# frozen_string_literal: true

class OAPI::OpenAPI::V30::Tags < OAPI::Types::Array
  class Tag < OAPI::Types::Object
    property :name
    property :description
    property :external_docs, OAPI::OpenAPI::V30::ExternalDocs
  end

  item :tag, Tag
end
