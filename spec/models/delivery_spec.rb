require 'rails_helper'

RSpec.describe BsCheckout::Delivery, type: :model do
  context 'validations' do
    %w[name interval price].each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
