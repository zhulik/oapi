# frozen_string_literal: true

class OAPI::OpenAPI::V30::Serializers::Ruby < OAPI::OpenAPI::V30::Serializers::Serializer
  private

  MAP_TEMPLATE = %(
<% object.store.each do |key, value| -%>
<% if value.is_a?(OAPI::Ref) -%>
<%= object.class.item_name %>("<%= key %>", ref: <%= serialize(value) %>)
<% else -%>
<%= object.class.item_name %>("<%= key %>") do
  <%= serialize_if_supported(value) %>
end
<% end -%>
<% end -%>
)

  ARRAY_TEMPLATE = %(
<% object.store.each do |item| -%>
<%= object.class.item_name %> do
  <%= serialize_if_supported(item) %>
end
<% end -%>
)

  OBJECT_TEMPLATE = %(
<% object.properties.each do |prop, value| -%>
<% if value.is_a?(OAPI::Ref) -%>
<%= prop %>(ref: <%= serialize(value) %>)
<% elsif supported?(value) -%>
<%= prop %> do
  <%= serialize(value) %>
end
<% elsif !value.nil? -%>
<%= prop %> <%= value_to_ruby(value) %>
<% end -%>
<% end -%>
)

  class Wrapper
    attr_reader :object

    def initialize(object) = @object = object

    def bind = binding

    def serialize(node) = OAPI::OpenAPI::V30::Serializers::Ruby.serialize(node)
    def supported?(node) = OAPI::OpenAPI::V30::Serializers::Ruby.supported?(node)
    def serialize_if_supported(node) = OAPI::OpenAPI::V30::Serializers::Ruby.serialize_if_supported(node)

    def value_to_ruby(value)
      return value.inspect if [Numeric, String, Array, TrueClass, FalseClass].any? { value.is_a?(_1) }
      return "(#{value.inspect})" if value.is_a?(Hash)

      raise ArgumentError, "value: #{value}"
    end
  end

  def serialize_ref(ref) = ref.ref.inspect
  def serialize_schema(schema) = schema.schema

  def serialize_map(map) = render(MAP_TEMPLATE, map)
  def serialize_array(array) = render(ARRAY_TEMPLATE, array)
  def serialize_object(object) = render(OBJECT_TEMPLATE, object)

  def serialize_definition(definition)
    %(
OAPI.define do
  #{serialize_object(definition)}
end
  )
  end

  def render(template, object) = ERB.new(template, trim_mode: "-").result(Wrapper.new(object).bind)
end
