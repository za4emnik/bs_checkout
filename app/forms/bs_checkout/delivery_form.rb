module BsCheckout
  class DeliveryForm
    include ActiveModel::Model
    include Virtus.model

    attribute :current_order, Order
    attribute :delivery_id, Integer

    validates :delivery_id, presence: true

    def save
      if valid?
        persist!
        true
      else
        false
      end
    end

    private

    def persist!
      current_order.delivery_id = delivery_id
      current_order.save
      current_order.update_total!
    end
  end
end
