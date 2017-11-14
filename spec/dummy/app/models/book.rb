class Book < ApplicationRecord
  validates :title, :price, presence: true
  has_many :order_items, class_name: 'BsCheckout::OrderItem', foreign_key: 'product_id'
end
