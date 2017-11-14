require 'ffaker'

FactoryGirl.define do
  factory :user do
    @pass = 'pAssWord123'
    email { FFaker::Internet.email }
    password @pass
    password_confirmation @pass
  end
end
