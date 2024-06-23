# frozen_string_literal: true

class OAPI::OpenAPI::V30::Serializers::JSON < OAPI::OpenAPI::V30::Serializers::Serializer
  using OAPI::Monkey

  private

  def serialize_ref(ref) = { "$ref": ref.ref }
  def serialize_schema(schema) = schema.schema
  def serialize_map(map) = map.store.transform_values { serialize_if_supported(_1) }
  def serialize_array(array) = array.store.map { serialize(_1) }

  def serialize_object(object)
    object.properties.each_with_object({}) do |(name, value), acc|
      next if value.nil?

      name = :in if name == :_in

      acc[name.camelize] = serialize_if_supported(value)
    end
  end
end
