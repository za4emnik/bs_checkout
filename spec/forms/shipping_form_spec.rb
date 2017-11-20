require 'rails_helper'

RSpec.describe BsCheckout::ShippingForm, type: :model do
  describe '#invalid?' do
    subject { BsCheckout::ShippingForm.new }

    it 'should return false if used billing address' do
      allow_any_instance_of(BsCheckout::ShippingForm).to receive(:use_billing_address).and_return true
      expect(subject.invalid?).to be_falsey
    end

    it 'should return true if not used billing address' do
      allow_any_instance_of(BsCheckout::ShippingForm).to receive(:use_billing_address).and_return false
      expect(subject.invalid?).to be_truthy
    end
  end
end
