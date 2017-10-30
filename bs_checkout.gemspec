$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bs_checkout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bs_checkout"
  s.version     = BsCheckout::VERSION
  s.authors     = ["za4emnik"]
  s.email       = ["maxots@rambler.ru"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BsCheckout."
  s.description = "TODO: Description of BsCheckout."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
