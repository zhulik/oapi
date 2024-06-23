# frozen_string_literal: true

module OAPI::Monkey
  refine Symbol do
    def camelize
      to_s.split("_").map(&:capitalize).join.tap do |a|
        a[0] = a[0].downcase
      end.to_sym
    end
  end
end
