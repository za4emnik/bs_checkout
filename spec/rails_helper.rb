ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'devise'
require 'capybara/poltergeist'
require 'shoulda-matchers'
require 'factory_girl_rails'
require 'database_cleaner'
require 'pry-rails'
require 'virtus'
require 'redcarpet'
require 'haml'

Capybara.javascript_driver = :poltergeist

Dir[Rails.root.join('../support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('../matchers/**/*.rb')].each { |f| require f }

ActiveRecord::Migrator.migrations_paths = 'spec/dummy/db/migrate'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FeatureLoginMacros, type: :feature
  config.include FeatureHelpModule

  config.extend LoginControllerMacros, type: :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

def main_app
  Rails.application.class.routes.url_helpers
end
