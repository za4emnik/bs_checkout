module BsCheckout
  class Cart < ApplicationRecord
    belongs_to :order
  end
end
