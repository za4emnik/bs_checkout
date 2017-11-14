require 'rails_helper'
require 'haml'

RSpec.describe BsCheckout::StepUpdateService do
  context '#initialize' do
    order = FactoryGirl.create(:order)
    subject { BsCheckout::StepUpdateService.new(:address, order, {}, 'session') }

    it_behaves_like 'controller have variables', 'step': Symbol, 'order': BsCheckout::Order, 'params': Hash, 'session': nil do
      let(:controller) { subject }
    end
  end

  context '#update' do
    %i[address delivery payment confirm].each do |step|
      it "should call ##{step} method" do
        order = FactoryGirl.create(:order)
        obj = BsCheckout::StepUpdateService.new(step, order, {}, 'session')
        expect(obj).to receive(step)
        obj.update
      end
    end
  end

  context '#address' do
    before do
      allow(subject).to receive(:address_params).and_return(address)
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:order) { FactoryGirl.create(:order, user: user) }
    let(:address) { FactoryGirl.attributes_for(:user_shipping_address).except!(:type, :use_billing_address) }
    subject { BsCheckout::StepUpdateService.new(:address, order, address, 'session') }

    it 'should set shipping address to form' do
      attrs = subject.address.shipping_address.attributes
      expect(attrs.delete_if { |item| address.exclude?(item) }).to eq(address)
    end

    it 'should set billing address to form' do
      attrs = subject.address.billing_address.attributes
      expect(attrs.delete_if { |item| address.exclude?(item) }).to eq(address)
    end

    it 'should return AddressForm instance' do
      expect(subject.address).to be_a_kind_of(BsCheckout::AddressForm)
    end
  end

  context '#delivery' do
    let(:delivery) { FactoryGirl.create(:delivery) }
    let(:params) { { order: { delivery: delivery.id } } }
    let(:order) { FactoryGirl.create(:order) }
    subject { BsCheckout::StepUpdateService.new(:address, order, params, 'session') }

    it 'should return DeliveryForm object' do
      expect(subject.delivery).to be_a_kind_of(BsCheckout::DeliveryForm)
    end
  end

  context '#payment' do
    before do
      allow(subject).to receive(:cart_params).and_return(cart)
    end

    let(:cart) { FactoryGirl.attributes_for(:cart) }
    let(:order) { FactoryGirl.create(:order) }
    subject { BsCheckout::StepUpdateService.new(:address, order, {}, 'session') }

    it 'should set order to form' do
      expect(subject.payment.order).to eq(order)
    end

    it 'should return CartForm object' do
      expect(subject.payment).to be_a_kind_of(BsCheckout::CartForm)
    end
  end

  context '#confirm' do
    let(:order) { FactoryGirl.create(:order) }
    subject { BsCheckout::StepUpdateService.new(:address, order, {}, steps_taken?: true) }

    it 'should change order\'s state' do
      expect(subject.instance_variable_get(:@order)).to receive(:waiting_processing!)
      subject.confirm
    end

    it 'should set :steps_taken? flag to false' do
      expect { subject.confirm }.to change { subject.instance_variable_get(:@session)[:steps_taken?] }.from(true).to(false)
    end

    it 'should return @order' do
      expect(subject.confirm).to eq(subject.instance_variable_get(:@order))
    end
  end
end
