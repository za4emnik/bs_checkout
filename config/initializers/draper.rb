require_dependency 'draper'

Draper.configure do |config|
  config.default_controller = BsCheckout::ApplicationController
end
