require 'draper'
require 'wicked'
require 'cancan'

module BsCheckout
  class Engine < ::Rails::Engine
    isolate_namespace BsCheckout
    require 'jquery-rails'
    require 'turbolinks'

    config.to_prepare do
      BsCheckout::ApplicationController.helper Rails.application.helpers
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
