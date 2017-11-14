module BsCheckout
  class Delivery < ApplicationRecord
    validates :name, :interval, :price, presence: true
  end
end
