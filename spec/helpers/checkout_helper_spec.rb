require 'rails_helper'

describe BsCheckout::CheckoutHelper do
  describe '#current_step' do
    it 'should return active class on current step' do
      assign(:step, 'some_step')
      expect(helper.current_step('some_step')).to eq('active')
    end

    it 'should return nil if not curent step' do
      assign(:step, 'some_step')
      expect(helper.current_step('some_step1')).to be_nil
    end
  end

  describe '#checked_delivery?' do
    it 'should return true if delivery was selected' do
      controller.params[:delivery_id] = 1
      expect(helper.checked_delivery?(1)).to be
    end
  end
end
