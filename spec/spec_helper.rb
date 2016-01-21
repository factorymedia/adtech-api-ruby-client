require 'simplecov'
require 'adtech-api-client'
require 'date'

SimpleCov.start do
 add_filter '/spec/'
end
Dir['lib/*.rb', 'lib/adtech/api/*.rb'].each {|file| load file }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
