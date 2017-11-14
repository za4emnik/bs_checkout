module BsCheckout
  class CreditCard < ApplicationRecord
    belongs_to :order
  end
end
