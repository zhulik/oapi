# frozen_string_literal: true

class OAPI::OpenAPI::V30::Serializers::JSON < OAPI::OpenAPI::V30::Serializers::Serializer
  using OAPI::Monkey

  private

  def serialize_ref(ref) = { "$ref": ref.ref }
  def serialize_schema(schema) = schema.schema
  def serialize_map(map) = map.store.transform_values { serialize_if_supported(_1) }
  def serialize_array(array) = array.store.map { serialize(_1) }

  def serialize_object(object)
    object.properties
          .compact
          .transform_keys { (_1 == :in ? :_in : _1.camelize) }
          .transform_values { serialize_if_supported(_1) }
  end
end
