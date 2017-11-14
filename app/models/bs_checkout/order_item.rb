module BsCheckout
  class OrderItem < ApplicationRecord
    include Draper::Decoratable

    belongs_to :order
    belongs_to :product, class_name: BsCheckout.product_class

    default_scope -> { preload(:product) }
  end
end
