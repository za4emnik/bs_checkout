require 'rails_helper'

RSpec.describe BsCheckout::Coupon, type: :model do
  context 'associations' do
    it { should belong_to(:order) }
  end

  context 'validations' do
    %w[code value].each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
