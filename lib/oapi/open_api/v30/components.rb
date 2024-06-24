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

  property :schemas, Schemas
  property :responses, OAPI::OpenAPI::V30::Responses
  property :parameters, Parameters
  property :examples, OAPI::OpenAPI::V30::Examples
  property :request_bodies, RequestBodies
  property :headers, OAPI::OpenAPI::V30::Headers
  property :security_schemes, SecuritySchemes
  property :links, OAPI::OpenAPI::V30::Links
  property :callbacks, OAPI::OpenAPI::V30::Callbacks
end
