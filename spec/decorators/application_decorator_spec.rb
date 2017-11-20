require 'rails_helper'

describe BsCheckout::ApplicationDecorator, type: :decorator do
  let(:order) { FactoryGirl.create(:order, billing_address: BsCheckout::BillingAddress.create(billing_address), shipping_address: BsCheckout::ShippingAddress.create(shipping_address)).decorate }
  let(:billing_address) { FactoryGirl.attributes_for(:user_billing_address) }
  let(:shipping_address) { FactoryGirl.attributes_for(:user_shipping_address) }

  before do
    order.instance_variable_set(:@context, order.h)
  end

  describe '#edit_link' do
    it 'should return edit link if confirm page' do
      allow(order.h.request).to receive(:fullpath).and_return('/confirm')
      expect(order.edit_link).to have_tag('a.general-edit', href: order.h.wizard_path(:address))
    end
  end

  describe '#checkout_index_page?' do
    it 'should return true if checkout index page' do
      allow(order.h.request).to receive(:fullpath).and_return(order.h.bs_checkout.root_path)
      expect(order.checkout_index_page?).to be_truthy
    end
  end

  describe '#show_billing_address' do
    it 'should render address partial' do
      expect(order.h).to receive(:render).with(partial: '/bs_checkout/checkout/address', locals: { obj: order.billing_address })
      order.show_billing_address
    end
  end

  describe '#show_shipping_address' do
    it 'should call #show_billing_address if used billing address' do
      allow(order.shipping_address).to receive(:use_billing_address).and_return true
      expect(order).to receive(:show_billing_address)
      order.show_shipping_address
    end

    it 'should render partial if use_billing_address not used' do
      allow(order.shipping_address).to receive(:use_billing_address).and_return false
      expect(order.h).to receive(:render).with(partial: '/bs_checkout/checkout/address', locals: { obj: order.shipping_address })
      order.show_shipping_address
    end
  end
end
