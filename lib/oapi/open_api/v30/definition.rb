# frozen_string_literal: true

class OAPI::OpenAPI::V30::Definition < OAPI::Types::Object
  property :openapi

  property :tags, OAPI::OpenAPI::V30::Tags
  property :servers, OAPI::OpenAPI::V30::Servers
  property :info, OAPI::OpenAPI::V30::Info
  property :external_docs, OAPI::OpenAPI::V30::ExternalDocs

  property :paths, OAPI::OpenAPI::V30::Paths

  property :components, OAPI::OpenAPI::V30::Components
  property :security

  def to_openapi = OAPI::OpenAPI::V30::Serializers::JSON.serialize(self)
  def to_ruby = OAPI::OpenAPI::V30::Serializers::Ruby.serialize(self)
end
