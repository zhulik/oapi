# frozen_string_literal: true

class OAPI::OpenAPI::V30::Links < OAPI::Types::Map
  class Link < OAPI::Types::Object
    property :operation_ref
    property :operation_id
    property :request_body
    property :description

    property :parameters # TODO: a custom type? https://spec.openapis.org/oas/v3.0.3#fixed-fields-16
    property :server, OAPI::OpenAPI::V30::Servers::Server

    class << self
      def parse(json)
        ref = json[:$ref]
        return OAPI::Ref.new(ref) if ref

        super
      end
    end
  end

  item :link, Link
end
