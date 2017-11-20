require 'rails_helper'

RSpec.describe BsCheckout::AddressBuildForm, type: :model do
  describe 'should be presence' do
    %w[first_name last_name address city zip phone].each do |field|
      it { should validate_presence_of(field) }
    end
  end

  describe 'length should be maximum 50' do
    %w[last_name city].each do |field|
      it { should validate_length_of(field).is_at_most(50) }
    end
    it { should validate_length_of(:phone).is_at_most(21) }
  end

  it { should validate_numericality_of(:zip) }
end
