# frozen_string_literal: true

require_relative "oapi/version"

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem

loader.inflector.inflect(
  "oapi" => "OAPI",
  "open_api" => "OpenAPI",
  "json" => "JSON"
)

loader.setup

module OAPI
  class Error < StandardError
    # Your code goes here...
  end

  class UnsupportedSpecVersion < Error
  end

  class << self
    def define(&)
      # TODO: check version
      # raise UnsupportedSpecVersion, "unsupported version #{version}" unless version.start_with?("3.0")

      OAPI::OpenAPI::V30::Definition.new(&)
    end

    def parse(json)
      version = json[:openapi]
      raise UnsupportedSpecVersion, "unsupported version #{version}" unless version.start_with?("3.0")

      OAPI::OpenAPI::V30::Definition.parse(json)
    end
  end
end
