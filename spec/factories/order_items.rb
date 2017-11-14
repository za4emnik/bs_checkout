FactoryGirl.define do
  factory :order_item, class: BsCheckout::OrderItem do
    association :product
    association :order
  end
end
