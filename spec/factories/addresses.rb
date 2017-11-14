FactoryGirl.define do
  factory :address, class: BsCheckout::Address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip 7777777
    association :country
    phone '+35566123457'
    association :addressable, factory: :user
    type 'ShippingAddress'

    trait :billing_address do
      type 'BsCheckout::BillingAddress'
    end

    trait :shipping_address do
      type 'BsCheckout::ShippingAddress'
      use_billing_address false
    end

    trait :user_address do
      association :addressable, factory: :user
    end

    trait :order_address do
      association :addressable, factory: :order
    end

    factory :user_billing_address,  traits: %i[billing_address user_address]
    factory :user_shipping_address, traits: %i[shipping_address user_address]
    factory :order_billing_address, traits: %i[billing_address order_address]
    factory :order_shipping_address, traits: %i[shipping_address order_address]
  end
end
