require 'rails_helper'
require 'cancan/matchers'

RSpec.describe BsCheckout::Ability, type: :model do
  describe '#initialize' do
    context 'when user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:order) { FactoryGirl.create(:order, user: user) }
      subject { BsCheckout::Ability.new(user) }

      it { should be_able_to(:manage, BsCheckout::Order.new(user_id: user.id)) }
      it { should be_able_to(:manage, BsCheckout::OrderItem.new(order: order).order(user_id: user.id)) }
    end

    context 'when guest' do
      subject { BsCheckout::Ability.new(User.new) }
      it { should be_able_to(:create, BsCheckout::OrderItem.new) }
    end
  end
end
