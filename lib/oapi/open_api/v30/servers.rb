# frozen_string_literal: true

class OAPI::OpenAPI::V30::Servers < OAPI::Types::Array
  class Server < OAPI::Types::Object
    class Variables < OAPI::Types::Map
      class Variable < OAPI::Types::Object
        property :enum
        property :default
        property :description
      end

      item :variable, Variable
    end

    property :url
    property :description

    property :variables, Variables
  end

  item :server, Server
end
