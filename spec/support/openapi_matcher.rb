# frozen_string_literal: true

RSpec::Matchers.define :be_a_valid_openapi_definition do |_expected|
  match do |actual|
    @document = Openapi3Parser.load(actual)
    @document.valid?
  end

  failure_message do |actual|
    # rubocop:disable Layout/LineLength
    "expected that\n#{actual.pretty_inspect}\nwould be a valid OpenAPI definition, but errors found:\n\n#{@document.errors.errors.map(&:message).pretty_inspect}"
    # rubocop:enable Layout/LineLength
  end
end
