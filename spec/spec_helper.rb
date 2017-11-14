require 'capybara/rspec'
require 'draper'
require 'rspec-html-matchers'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.tty = true

  config.before(:each, type: :decorator) do
    Draper::HelperProxy.public_send(:include, DecoratorHelpModule)
    Draper::ViewContext.controller = BsCheckout::ApplicationController.new
    config.include RSpecHtmlMatchers
    config.include Capybara::RSpecMatchers
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
