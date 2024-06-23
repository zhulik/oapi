# frozen_string_literal: true

class OAPI::OpenAPI::V30::Components < OAPI::Types::Object
  class Schemas < OAPI::Types::Map
    item :schema, OAPI::Schema
  end

  class Parameters < OAPI::Types::Map
    item :parameter, OAPI::OpenAPI::V30::Parameters::Parameter
  end

  class RequestBodies < OAPI::Types::Map
    item :body, OAPI::OpenAPI::V30::RequestBody
  end

  class SecuritySchemes < OAPI::Types::Map
    class Scheme < OAPI::Types::Object
      class Flows < OAPI::Types::Object
        class Flow < OAPI::Types::Object
          property :authorization_url
          property :token_url
          property :refresh_url
          property :scopes
        end

        property :implicit, Flow
        property :password, Flow
        property :client_credentials, Flow
        property :authorization_code, Flow
      end

      property :type
      property :description
      property :name
      property :_in
      property :scheme
      property :bearer_format
      property :open_id_connect_url

      property :flows, Flows
    end

    item :scheme, Scheme
  end

  class Links < OAPI::Types::Map
    class Link < OAPI::Types::Object
      property :operation_ref
      property :operation_id
      property :request_body
      property :description

      property :parameters # TODO: a custom type? https://spec.openapis.org/oas/v3.0.3#fixed-fields-16
      property :server, OAPI::OpenAPI::V30::Servers::Server
    end

    item :link, Link
  end

  property :schemas, Schemas
  property :responses, OAPI::OpenAPI::V30::Responses
  property :parameters, Parameters
  property :examples, OAPI::OpenAPI::V30::Examples
  property :request_bodies, RequestBodies
  property :headers, OAPI::OpenAPI::V30::Headers
  property :security_schemes, SecuritySchemes
  property :links, Links
  property :callbacks, OAPI::OpenAPI::V30::Callbacks
end
