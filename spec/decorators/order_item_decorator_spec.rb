require 'rails_helper'

describe BsCheckout::OrderItemDecorator, type: :decorator do
  let(:book) { FactoryGirl.create(:product, price: 10) }
  let(:order_item) { FactoryGirl.create(:order_item, product: book, quantity: 5).decorate }

  before do
    order_item.instance_variable_set(:@context, order_item.h)
  end

  describe '#quantity_field' do
    it 'should render quantity_field partial' do
      allow(order_item).to receive(:checkout_index_page?).and_return true
      expect(order_item.h).to receive(:render).with(partial: 'bs_checkout/checkout/quantity_field', locals: { field: 'field', item: 'item' })
      order_item.quantity_field('field', 'item')
    end

    it 'should return quantity' do
      allow(order_item).to receive(:checkout_index_page?).and_return false
      expect(order_item.quantity_field('field', 'item')).to have_content(order_item.quantity)
    end
  end

  describe '#delete_button' do
    it 'should return delete button' do
      allow(order_item).to receive(:checkout_index_page?).and_return true
      expect(order_item.delete_button(order_item)).to have_tag('a', href: order_item.h.bs_checkout.order_item_path(order_item.id), 'data-method': 'delete')
    end
  end

  describe '#show_subtotal' do
    it 'should return subtotal value' do
      expect(order_item.show_subtotal).to eq(50)
    end
  end
end
