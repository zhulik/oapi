# frozen_string_literal: true

require "yaml"
require "active_support/all"

require "simplecov"

SimpleCov.start

require "oapi"
require "openapi3_parser"

Dir["#{__dir__}/support/**/*.rb"].each { |f| load(f) }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
