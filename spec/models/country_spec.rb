require 'rails_helper'

RSpec.describe BsCheckout::Country, type: :model do
  context 'scopes' do
    it 'should order ascending by default' do
      %w[Ukraine Andorra Yemen].each do |country|
        FactoryGirl.create(:country, name: country)
      end
      expect(BsCheckout::Country.all).to eq(BsCheckout::Country.all.order(name: :asc))
    end
  end
end
