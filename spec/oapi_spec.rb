# frozen_string_literal: true

RSpec.describe OAPI do
  it "has a version number" do
    expect(OAPI::VERSION).not_to be_nil
  end

  describe ".define" do
    it "builds an openapi definition" do
      definition = described_class.define do
        openapi "3.0"

        info do
          title "Awesome api"
          description "Some awesome api description"
          terms_of_service "htts://example.com"
          version "1.0"

          contact do
            name "John Doe"
            url "htts://example.com"
            email "john@example.com"
          end

          license do
            name "MIT"
            url "htts://example.com"
          end
        end

        servers do
          server do
            url "https://example.com"
            description "server description"

            variables do
              variable(:some_variable) do
                enum ["foo", "bar"]
                default "some_value"
                description "variable description"
              end
            end
          end
        end

        tags do
          tag do
            name "some tag"
            description "tag description"

            external_docs do
              description "tag external doc"
              url "https://example.com"
            end
          end
        end

        external_docs do
          description "api external doc"
          url "https://example.com"
        end

        security([{ foo: ["bar", "baz"] }])

        paths do
          path("/pets") do
            get do
              description "operation description"
              summary "operation summary"
              operation_id "petsGet"

              deprecated false
              tags ["tag3", "tag4"]
              security([{ foo: ["bar", "baz"] }])

              external_docs do
                description "operation external doc"
                url "https://example.com"
              end

              callbacks do
                callback(:oncallback) do
                  path("/callback") do
                    post do
                      responses do
                        response(200) do
                          description "callback response description"
                        end
                      end

                      request_body do
                        content do
                          media_type("application/json") do
                            schema do
                              {
                                type: "object"
                              }
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end

              parameters do
                parameter do
                  name "Some parameter"
                  _in "query"
                  description "some parameter description"
                  required true
                  deprecated false
                  explode false
                  allow_reserved false
                  example "some value"
                end
              end

              servers do
                server do
                  url "https://example.com"
                  description "server description"
                end
              end

              responses do
                response(200) do
                  description "/pets description"

                  content do
                    media_type("application/json") do
                      schema do
                        {
                          type: "object"
                        }
                      end

                      examples do
                        example(:someExample) do # rubocop:disable RSpec/NoExpectationExample
                          summary "example summary"
                          description "example description"
                          value "example value"
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end

        components do
          schemas do
            schema(:someSchema) do
              {
                type: "object"
              }
            end
          end

          responses do
            response(:someResponse) do
              description "Response Description"
            end
          end

          parameters do
            parameter(:someParameter) do
              name "someParamter"
              _in "query"
            end
          end

          examples do
            example(:someExample) do # rubocop:disable RSpec/NoExpectationExample
              summary "example summary"
              description "example description"
              external_value "htts://exampl.com"
            end
          end

          request_bodies do
            body(:someBody) do
              content do
                media_type("application/json")
              end
            end
          end

          headers do
            header(:someHeader) do
              description "header description"
              schema ref: "#/components/schemas/someSchema"
            end
          end

          security_schemes do
            scheme(:api_key) do
              type "apiKey"
              name "key"
              _in "header"
            end
          end

          links do
            link(:someLink) do
              operation_id "linkOperationId"
              description "link description"

              parameters({})
              request_body({})

              server do
                url "https://example.com"
              end
            end
          end

          callbacks do
            callback(:someCallback) do
              path("/callback")
            end
          end
        end
      end.to_openapi

      expect(definition).to be_a_valid_openapi_definition

      expect(definition).to eq(
        { info: { title: "Awesome api",
                  description: "Some awesome api description",
                  termsOfService: "htts://example.com",
                  version: "1.0",
                  contact: { name: "John Doe", url: "htts://example.com", email: "john@example.com" },
                  license: { name: "MIT", url: "htts://example.com" } },
          servers: [{ url: "https://example.com",
                      description: "server description",
                      variables: { some_variable: { enum: ["foo", "bar"], default: "some_value",
                                                    description: "variable description" } } }],
          tags: [{ name: "some tag", description: "tag description",
                   externalDocs: { description: "tag external doc", url: "https://example.com" } }],
          externalDocs: { description: "api external doc", url: "https://example.com" },
          security: [{ foo: ["bar", "baz"] }],
          paths: { "/pets" =>
      { get: { description: "operation description",
               summary: "operation summary",
               operationId: "petsGet",
               deprecated: false,
               tags: ["tag3", "tag4"],
               security: [{ foo: ["bar", "baz"] }],
               externalDocs: { description: "operation external doc", url: "https://example.com" },
               callbacks: { oncallback:
            { "/callback" =>
              { post: { responses: { 200 => { description: "callback response description" } },
                        requestBody: { content: { "application/json" => { schema: { type: "object" } } } } } } } },
               parameters: [{ name: "Some parameter",
                              in: "query",
                              description: "some parameter description",
                              required: true,
                              deprecated: false,
                              explode: false,
                              allowReserved: false,
                              example: "some value" }],
               servers: [{ url: "https://example.com", description: "server description" }],
               responses: { 200 =>
            { description: "/pets description",
              content: { "application/json" =>
                { schema: { type: "object" },
                  examples: { someExample: { summary: "example summary", description: "example description",
                                             value: "example value" } } } } } } } } },
          components: { schemas: { someSchema: { type: "object" } },
                        responses: { someResponse: { description: "Response Description" } },
                        parameters: { someParameter: { name: "someParamter", in: "query" } },
                        examples: { someExample: { summary: "example summary", description: "example description",
                                                   externalValue: "htts://exampl.com" } },
                        requestBodies: { someBody: { content: { "application/json" => {} } } },
                        headers: { someHeader: { description: "header description",
                                                 schema: { :$ref => "#/components/schemas/someSchema" } } },
                        securitySchemes: { api_key: { type: "apiKey", name: "key", in: "header" } },
                        links: { someLink:
        { operationId: "linkOperationId",
          description: "link description",
          parameters: {},
          requestBody: {},
          server: { url: "https://example.com" } } },
                        callbacks: { someCallback: { "/callback" => {} } } },
          openapi: "3.0" }
      )
    end
  end

  describe ".parse" do
    subject { described_class.parse(json) }

    Dir.glob("spec/fixtures/open_api/**/*.yaml").each do |path|
      context "when parsing #{path}" do
        let(:json) { YAML.safe_load_file("spec/fixtures/open_api/3.0/petstore.yaml", symbolize_names: true) }

        it "returns parsed openapi definition" do
          expect(subject.to_openapi.deep_symbolize_keys).to eq(json.deep_symbolize_keys)
        end
      end
    end
  end
end
