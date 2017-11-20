require 'rails_helper'

RSpec.describe BsCheckout::OrderItemsController, type: :controller do
  routes { BsCheckout::Engine.routes }
  describe '#create' do
    let (:order_item_attibutes) { FactoryGirl.attributes_for(:order_item) }
    subject { post :create, params: { order_item: order_item_attibutes } }

    it 'quantity should be 1' do
      subject
      expect(controller.current_order.order_items[0].quantity).to eq 1
    end

    it_should_behave_like 'redirect to root page'
  end

  describe '#destroy' do
    login_user
    let (:order) { FactoryGirl.create(:order, user: controller.current_user) }
    let (:order_item) { FactoryGirl.create(:order_item, order: order) }
    subject { delete :destroy, params: { id: order_item.id } }

    it 'should delete order item' do
      order_item
      expect { subject }.to change(BsCheckout::OrderItem, :count).by(-1)
    end

    it_should_behave_like 'redirect to root page'
  end
end
