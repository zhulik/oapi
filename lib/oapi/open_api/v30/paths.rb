# frozen_string_literal: true

class OAPI::OpenAPI::V30::Paths < OAPI::Types::Map
  class Path < OAPI::Types::Object
    class Operation < OAPI::Types::Object
      property :description
      property :summary
      property :operation_id
      property :deprecated
      property :tags
      property :security

      property :servers, OAPI::OpenAPI::V30::Servers
      property :responses, OAPI::OpenAPI::V30::Responses
      property :external_docs, OAPI::OpenAPI::V30::ExternalDocs
      property :callbacks, OAPI::OpenAPI::V30::Callbacks
      property :parameters, OAPI::OpenAPI::V30::Parameters
      property :request_body, OAPI::OpenAPI::V30::RequestBody
    end

    [:get, :post, :put, :patch, :delete].each do |method|
      property method, Operation
    end
  end

  item :path, Path
end
