require_dependency 'aasm'

module BsCheckout
  class Order < ApplicationRecord
    include Draper::Decoratable
    include AASM

    after_create :generate_order_number

    has_one :coupon
    has_one :credit_card
    has_one :shipping_address, as: :addressable, dependent: :destroy
    has_one :billing_address, as: :addressable, dependent: :destroy
    has_many :order_items
    belongs_to :user, class_name: BsCheckout.user_class, optional: true
    belongs_to :delivery

    aasm do
      state :pending, initial: true
      state :waiting_for_processing
      state :in_progress
      state :in_delivery
      state :delivered
      state :cancelled

      event :waiting_processing do
        transitions from: :pending, to: :waiting_for_processing
      end

      event :progress do
        transitions from: :waiting_for_processing, to: :in_progress
      end

      event :delivered do
        transitions from: :in_progress, to: :in_delivery
      end

      event :complete do
        transitions from: :in_delivery, to: :delivered
      end

      event :cancelled do
        transitions from: Order.aasm.states.map(&:name) - [:cancelled], to: :cancelled
      end
    end

    def self.with_filter(filter)
      if Order.aasm.states.map(&:name).include?(filter&.to_sym)
        where(aasm_state: filter)
      else
        all
      end
    end

    def update_total!
      estimation = coupon ? coupon.value : 0
      estimation -= delivery.price if delivery
      self.total = subtotal - estimation
      save
    end

    def subtotal!
      self.subtotal = order_items.collect { |item| item.quantity * item.product.price }.sum
      save
    end

    private

    def generate_order_number
      update!(number: format('R%08d', id))
    end
  end
end
