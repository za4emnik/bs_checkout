require 'rails_helper'

describe BsCheckout::OrderDecorator, type: :decorator do
  let(:coupon) { FactoryGirl.build(:coupon) }
  let(:delivery) { FactoryGirl.build(:delivery) }
  let(:billing_address) { FactoryGirl.attributes_for(:user_billing_address) }
  let(:shipping_address) { FactoryGirl.attributes_for(:user_shipping_address) }
  let(:order) { FactoryGirl.create(:order, coupon: coupon, delivery: delivery).decorate }

  describe '#summary_coupon' do
    it 'should return coupon info' do
      expect(order.summary_coupon).to have_content(coupon.value)
    end
  end

  describe '#summary_delivery' do
    it 'should return delivery info' do
      expect(order.summary_delivery).to have_content(delivery.price)
    end
  end

  describe '#delete_button_header' do
    it 'should return close button' do
      allow(order).to receive(:checkout_index_page?).and_return true
      expect(order.delete_button_header).to have_tag('th.col-close')
    end
  end

  describe '#show_total' do
    it 'should return total price' do
      expect(order.show_total).to eq(order.total)
    end

    it 'should return 0 if total is negative' do
      BsCheckout::Order.new
      allow_any_instance_of(BsCheckout::Order).to receive(:total).and_return(-1)
      expect(order.show_total).to eq(0)
    end
  end

  describe '#render_shipping_address' do
    before do
      order.billing_address = BsCheckout::BillingAddress.create(billing_address)
    end

    it 'should render billing_address if shipping_address is nil' do
      expect(order.h).to receive(:render).with(partial: '/bs_checkout/checkout/address', locals: { obj: order.billing_address })
      order.render_shipping_address
    end

    it 'should render billing_address if use_billing_address is used' do
      order.shipping_address = BsCheckout::ShippingAddress.create(shipping_address)
      allow(order.shipping_address).to receive(:use_billing_address).and_return true
      expect(order.h).to receive(:render).with(partial: '/bs_checkout/checkout/address', locals: { obj: order.billing_address })
      order.render_shipping_address
    end

    it 'should render shipping if shipping_address is not nil' do
      order.shipping_address = BsCheckout::ShippingAddress.create(shipping_address)
      expect(order.h).to receive(:render).with(partial: '/bs_checkout/checkout/address', locals: { obj: order.shipping_address })
      order.render_shipping_address
    end
  end

  describe '#filtred_card_number' do
    it 'should filter number of cart' do
      order.credit_card = FactoryGirl.create(:credit_card, number: '000000000000000003577')
      expect(order.filtred_card_number).to eq('*****************3577')
    end
  end

  describe '#show_order_title' do
    it 'should return \'my orders\' title if orders are present' do
      allow(order.h).to receive_message_chain(:current_user, :orders).and_return([order, order])
      allow(order).to receive(:aasm_state).and_return('waiting_for_processing')
      expect(order.show_order_title).to eq(I18n.t(:my_orders))
    end

    it 'should return \'no orders\' title if orders are not present' do
      allow(order.h).to receive_message_chain(:current_user, :orders).and_return([])
      expect(order.show_order_title).to eq(I18n.t(:no_orders))
    end
  end
end
