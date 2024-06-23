# frozen_string_literal: true

class OAPI::OpenAPI::V30::RequestBody < OAPI::Types::Object
  property :description
  property :required
  property :content, OAPI::OpenAPI::V30::Content
end
