# frozen_string_literal: true

class OAPI::OpenAPI::V30::Headers < OAPI::Types::Map
  class Header < OAPI::Types::Object
  end

  item :header, OAPI::OpenAPI::V30::Parameters::Parameter # https://spec.openapis.org/oas/v3.0.3#header-object
end
