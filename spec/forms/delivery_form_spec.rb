require 'rails_helper'

RSpec.describe BsCheckout::DeliveryForm, type: :model do
  describe 'should presence' do
    it { should validate_presence_of(:delivery_id) }
  end
end
