# frozen_string_literal: true

class OAPI::OpenAPI::V30::Serializers::Serializer
  FUNCTIONS = { # order matters
    OAPI::Ref => "serialize_ref",
    OAPI::Schema => "serialize_schema",
    OAPI::OpenAPI::V30::Definition => "serialize_definition",
    OAPI::Types::Map => "serialize_map",
    OAPI::Types::Array => "serialize_array",
    OAPI::Types::Object => "serialize_object"
  }.freeze

  class << self
    def serialize(node) = new.send(serializer(node), node)
    def serializer(node) = FUNCTIONS.find { |k, _| node.is_a?(k) }&.at(1)
    def supported?(node) = !serializer(node).nil?
    def serialize_if_supported(node) = supported?(node) ? serialize(node) : node
  end

  private

  def serialize_if_supported(*) = self.class.serialize_if_supported(*)
  def serialize(*) = self.class.serialize(*)

  def serialize_ref(ref) = raise NotImplementedError
  def serialize_schema(schema) = raise NotImplementedError
  def serialize_definition(definition) = serialize_object(definition)
  def serialize_map(map) = raise NotImplementedError
  def serialize_array(array) = raise NotImplementedError
  def serialize_object(object) = raise NotImplementedError
end
