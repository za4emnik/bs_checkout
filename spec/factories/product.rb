FactoryGirl.define do
  factory :product, class: Book do
    title 'Title'
    price 100
    image '/d-a.png'
  end
end
