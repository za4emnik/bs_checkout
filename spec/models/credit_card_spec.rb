require 'rails_helper'

RSpec.describe BsCheckout::CreditCard, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
  end
end
