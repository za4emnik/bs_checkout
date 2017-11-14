require 'rails_helper'
require 'aasm/rspec'

RSpec.describe BsCheckout::Order, type: :model do
  describe 'associations' do
    it { should have_one(:coupon) }
    it { should have_one(:cart) }
    it { should have_many(:order_items) }
    it { should belong_to(:user) }
    it { should belong_to(:delivery) }
  end

  describe 'change of states' do
    it { expect(subject).to transition_from(:pending).to(:waiting_for_processing).on_event(:waiting_processing) }
    it { expect(subject).to transition_from(:waiting_for_processing).to(:in_progress).on_event(:progress) }
    it { expect(subject).to transition_from(:in_progress).to(:in_delivery).on_event(:delivered) }
    it { expect(subject).to transition_from(:in_delivery).to(:delivered).on_event(:complete) }
    states = BsCheckout::Order.aasm.states.map(&:name) - [:cancelled]
    states.each do |state|
      it { expect(subject).to transition_from(state).to(:cancelled).on_event(:cancelled) }
    end
  end

  describe '#with_filter' do
    states = %w[waiting_for_processing in_progress in_delivery delivered]

    before do
      states.each do |state|
        2.times { FactoryGirl.create(:order, aasm_state: state) }
      end
    end

    states.each do |state|
      it "should return records with state #{state}" do
        expect(BsCheckout::Order.with_filter(state)).to eq(BsCheckout::Order.where(aasm_state: state))
      end
    end

    it 'shoulf return all records if unknow state' do
      expect(BsCheckout::Order.with_filter('some_unknow_state')).to eq(BsCheckout::Order.all)
    end
  end

  describe '#update_total!' do
    let (:coupon) { FactoryGirl.create(:coupon) }
    let (:delivery) { FactoryGirl.create(:delivery) }
    subject { FactoryGirl.create(:order, coupon: coupon, delivery: delivery) }

    it 'should update total' do
      value = subject.subtotal - subject.coupon.value + subject.delivery.price
      subject.update_total!
      expect(subject.total).to eq(value)
    end
  end

  describe '#subtotal!' do
    subject { FactoryGirl.create(:order) }

    it 'should update subtotal' do
      FactoryGirl.create(:order_item, order_id: subject.id)
      allow_any_instance_of(BsCheckout::OrderItem).to receive_message_chain(:product, :price).and_return(100)

      value = subject.order_items[0].quantity * subject.order_items[0].product.price
      subject.subtotal!
      expect(subject.subtotal).to eq(value)
    end
  end

  describe 'generate orders numbers' do
    let(:order) { FactoryGirl.create(:order) }

    it 'should generate order with format \'R00000000\'' do
      expect(order.number).to match(/^(R)([\d]){8}$/)
    end

    it 'number should include order id' do
      order = FactoryGirl.create(:order, id: 55_555)
      expect(order.number).to eq('R00055555')
    end
  end
end
