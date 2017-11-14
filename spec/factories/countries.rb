FactoryGirl.define do
  factory :country, class: BsCheckout::Country do
    name { FFaker::AddressUA.country }
  end
end
