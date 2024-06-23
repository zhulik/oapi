# frozen_string_literal: true

class OAPI::Types::Object
  using OAPI::Monkey

  include OAPI::Properties

  class << self
    def parse(json)
      new.tap do |obj|
        (properties || []).each do |name, type|
          value = json[name.camelize]
          next if value.nil?

          value = type.parse(value) if value.is_a?(Hash) || (value.is_a?(Array) && type)
          obj.send(name, value)
        end
      end
    end
  end
end
