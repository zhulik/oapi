# frozen_string_literal: true

module OAPI::Extensions
  def extensions = @extensions ||= {}

  def respond_to_missing?(name, _) = name.to_s.start_with?("x_") || super

  def method_missing(name, *)
    super unless name.to_s.start_with?("x_")

    raise ArgumentError, "extension value #{name} is already assigned" if extensions.include?(name)

    extensions[name] = yield
  end
end
