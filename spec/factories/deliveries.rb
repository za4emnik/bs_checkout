FactoryGirl.define do
  factory :delivery, class: BsCheckout::Delivery do
    name { FFaker::UnitMetric.area_abbr }
    interval { FFaker::AddressGR.neighborhood }
    price 100
  end
end
