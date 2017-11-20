require 'rails_helper'

RSpec.describe BsCheckout::CheckoutController, type: :controller do
  routes { BsCheckout::Engine.routes }
  steps = %w[address delivery payment confirm complete]

  describe '#update_cart' do
    let!(:order) { FactoryGirl.create(:order) }
    let!(:order_item) { FactoryGirl.create(:order_item, order: order, quantity: 0) }
    let!(:item) { FactoryGirl.attributes_for(:order_item, quantity: 5) }
    subject { put :update_cart, params: { id: 'address', order_items: { order_item.id => item }, order: { coupon: true } } }
    routes { BsCheckout::Engine.routes }

    context 'when logged' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(order.user)
        allow(controller).to receive(:current_user).and_return(order.user)
      end

      it 'should update order items' do
        order.order_items << order_item
        expect { subject }.to change { BsCheckout::OrderItem.find(order_item.id).quantity }.from(order_item.quantity).to(item[:quantity])
      end

      it 'should call #check_coupon if coupon is entered' do
        expect(controller).to receive(:check_coupon)
        subject
      end

      it 'should redirect to home page' do
        subject
        request.env['HTTP_REFERER'] = root_url
        expect(response).to redirect_to(root_url)
      end
    end

    it_behaves_like 'when guest' do
      subject { put :update_cart, params: { id: 'address', order_items: { order_item.id => item }, order: { coupon: false } } }
    end
  end

  describe '#show' do
    context 'when logged' do
      before do
        user = FactoryGirl.create(:user)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      before do
        allow(controller).to receive(:check_order)
        subject
      end

      steps.each do |step|
        context "#{step} step" do
          subject { get :show, params: { id: :"#{step}" } }

          it_behaves_like 'controller have variables', 'form': nil unless step == 'complete'
          it_behaves_like 'given page'
        end
      end
    end

    context 'when guest' do
      steps.each do |step|
        context "#{step} step" do
          subject { get :show, params: { id: :"#{step}" } }

          it_should_behave_like 'when guest'
        end
      end
    end
  end

  describe '#update' do
    let(:order) { FactoryGirl.create(:order) }

    context 'when logged' do
      before do
        user = FactoryGirl.create(:user)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      context 'address step' do
        shipping = FactoryGirl.attributes_for(:order_shipping_address)
        billing = FactoryGirl.attributes_for(:order_billing_address)
        subject { put :update, params: { id: :address, address_form: { billing_form: billing, shipping_form: shipping } } }

        it_behaves_like 'controller have variables', 'form': nil
      end

      context 'delivery step' do
        delivery = FactoryGirl.create(:delivery)
        subject { put :update, params: { id: :delivery, order: { delivery: delivery.id } } }

        it_behaves_like 'controller have variables', 'form': nil
      end

      context 'payment step' do
        credit_card = FactoryGirl.attributes_for(:credit_card)
        subject { put :update, params: { id: :payment, credit_card_form: credit_card } }

        it_behaves_like 'controller have variables', 'form': nil
      end

      context 'confirm step' do
        subject { put :update, params: { id: :confirm } }

        it_behaves_like 'controller have variables', 'form': nil
      end
    end

    context 'when guest' do
      steps.each do |step|
        context "#{step} step" do
          subject { put :update, params: { id: :"#{step}" } }

          it_should_behave_like 'when guest'
        end
      end
    end
  end
end
