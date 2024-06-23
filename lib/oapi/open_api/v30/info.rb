# frozen_string_literal: true

class OAPI::OpenAPI::V30::Info < OAPI::Types::Object
  class Contact < OAPI::Types::Object
    property :name
    property :url
    property :email
  end

  class License < OAPI::Types::Object
    property :name
    property :identifier
    property :url
  end

  property :title
  property :description
  property :terms_of_service
  property :version

  property :contact, Contact
  property :license, License
end
