require 'bs_checkout/engine'
require 'devise'

module BsCheckout
  mattr_accessor :user_class
  mattr_accessor :product_class
end
