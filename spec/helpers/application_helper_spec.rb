require 'rails_helper'

describe BsCheckout::ApplicationHelper do
  describe '#items_in_cart' do
    let(:order_item) { FactoryGirl.create(:order_item) }

    it 'should return count items in cart if items exist' do
      @request.session['order_id'] = order_item.order.id
      expect(helper.items_in_cart).to eq(1)
    end

    it 'should return zero if items not found' do
      expect(helper.items_in_cart).to eq(0)
    end
  end
end
