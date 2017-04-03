ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require 'rspec/rails'
require "webmock/rspec"
require "vcr"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.color                      = true
  config.tty                        = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.order = :random
end

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")

  c.hook_into :webmock

  c.ignore_localhost         = true
  c.default_cassette_options = { :match_requests_on => [ :method, VCR.request_matchers.uri_without_param(:fields) ] }
end
