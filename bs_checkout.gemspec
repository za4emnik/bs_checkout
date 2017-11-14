$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'bs_checkout/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'bs_checkout'
  s.version     = BsCheckout::VERSION
  s.authors     = ['za4emnik']
  s.email       = ['maxots@rambler.ru']
  s.homepage    = 'https://github.com/za4emnik/bs_checkout'
  s.summary     = 'Checkout'
  s.description = 'Simply checkout for your e-commerce project'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib,decorators,services,forms,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.2'
  s.add_dependency 'wicked'
  s.add_dependency 'devise'
  s.add_dependency 'draper', '3.0.1'
  s.add_dependency 'aasm'
  s.add_dependency 'cancan'
  s.add_dependency 'haml'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'turbolinks'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'virtus'
  s.add_dependency 'redcarpet'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-html-matchers'
end
