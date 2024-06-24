# frozen_string_literal: true

class OAPI::OpenAPI::V30::Responses < OAPI::Types::Map
  class Response < OAPI::Types::Object
    property :description

    property :content, OAPI::OpenAPI::V30::Content
    property :headers, OAPI::OpenAPI::V30::Headers

    property :links, OAPI::OpenAPI::V30::Links
  end

  item :response, Response
end
