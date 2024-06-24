# frozen_string_literal: true

RSpec.describe OAPI::OpenAPI::V30::Definition do
  describe ".to_ruby" do
    Dir.glob("spec/fixtures/open_api/**/*.yaml").each do |path|
      context "when loading #{path}" do
        let(:json) { YAML.safe_load_file(path, symbolize_names: true) }
        let(:definition) { OAPI.parse(json) }

        it "returns an equivalent representation in ruby" do
          ruby = definition.to_ruby
          # puts(ruby)
          openapi = eval(ruby).to_openapi # rubocop:disable Security/Eval

          expect(openapi).to be_a_valid_openapi_definition
          expect(openapi[:paths].deep_symbolize_keys).to eq(json[:paths].deep_symbolize_keys)
        end
      end
    end
  end
end
