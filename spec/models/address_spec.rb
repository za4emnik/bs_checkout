require 'rails_helper'

RSpec.describe BsCheckout::Address, type: :model do
  context 'associations' do
    it { should belong_to(:addressable) }
    it { should belong_to(:country) }
  end

  context '#full_name' do
    it 'should return full name' do
      address = FactoryGirl.create(:address)
      expect(address.full_name).to eq("#{address.first_name} #{address.last_name}")
    end
  end
end
