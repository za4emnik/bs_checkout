$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bs_checkout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bs_checkout"
  s.version     = BsCheckout::VERSION
  s.authors     = ["za4emnik"]
  s.email       = ["maxots@rambler.ru"]
  s.homepage    = "https://github.com/za4emnik/bs_checkout"
  s.summary     = "Checkout"
  s.description = "Simply checkout for your e-commerce project"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"
end
