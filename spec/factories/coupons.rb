FactoryGirl.define do
  factory :coupon, class: BsCheckout::Coupon do
    code { FFaker::Guid.guid }
    value 100
    association :order
  end
end
