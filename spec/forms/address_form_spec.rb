require 'rails_helper'

RSpec.describe BsCheckout::AddressForm, type: :model do
  let(:address_form) { BsCheckout::AddressForm.new }

  describe '#all_addresses_valid' do
    it 'should adds errors if some addresses not valid' do
      expect(address_form.errors).to receive(:add).with(:billing_address, address_form.billing_address.errors.messages)
      expect(address_form.errors).to receive(:add).with(:shipping_address, address_form.shipping_address.errors.messages)
      address_form.all_addresses_valid
    end
  end
end
