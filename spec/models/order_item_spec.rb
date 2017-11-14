require 'rails_helper'

RSpec.describe BsCheckout::OrderItem, type: :model do
  context 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:order) }
  end
end
