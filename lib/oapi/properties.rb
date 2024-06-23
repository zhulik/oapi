# frozen_string_literal: true

module OAPI::Properties
  module ClassMethods
    attr_reader :properties

    def property(name, object = nil) # rubocop:disable Metrics/MethodLength
      @properties ||= {}
      @properties[name] = object

      define_method(name) do |value = nil, ref: nil, &block|
        if object.nil?
          raise ArgumentError, "value must be passed" if value.nil?

          return instance_variable_set(:"@#{name}", value)
        end

        if [NilClass, object, OAPI::Ref].none? { value.is_a?(_1) }
          raise ArgumentError, "given value must be of type #{object} or #{OAPI::Ref} given: #{value}"
        end
        raise ArgumentError, "ref and block are mutual exclusive" if ref && block

        instance_variable_set(:"@#{name}", parse_property_value(value, object, ref, block))
      end
    end
  end

  class << self
    def included(base)
      base.extend(ClassMethods)
    end
  end

  def initialize(&)
    instance_exec(&) if block_given?
  end

  def properties
    self.class.properties.keys.each_with_object({}) do |prop, acc|
      acc[prop] = instance_variable_get(:"@#{prop}")
    end
  end

  def parse_property_value(value, object, ref, block)
    if ref
      OAPI::Ref.new(ref)
    elsif block
      object.new(&block)
    elsif !value.nil?
      value
    else
      raise ArgumentError, "ref, block or value must be provided"
    end
  end
end
