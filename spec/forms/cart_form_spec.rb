require 'rails_helper'

RSpec.describe BsCheckout::CartForm, type: :model do
  describe 'validates' do
    %w[number name date cvv order].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should allow_values('11/15', '01/16').for(:date) }
    it { should_not allow_values('13/15').for(:date) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should allow_values('12345678901234567').for(:number) }
    it { should_not allow_values('12345g-78901q3s56t').for(:number) }
    it { should allow_values('123').for(:cvv) }
    it { should allow_values('1234').for(:cvv) }
    it { should_not allow_values('2q3').for(:cvv) }
  end
end
