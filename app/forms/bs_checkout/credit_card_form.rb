module BsCheckout
  class CreditCardForm
    include ActiveModel::Model
    include Virtus.model

    attribute :order, Order, default: CreditCard.new

    attribute :number, String
    attribute :name, String
    attribute :date, String
    attribute :cvv, Integer

    validates :number, :name, :date, :cvv, :order, presence: true
    validates :date, format: { with: %r{\A([0][1-9]|[1][0-2])(\/)([1-3][0-9])\Z} }
    validates :name, length: { maximum: 50 }
    validates :number, format: { with:  /\A[0-9]{16,21}\Z/ }
    validates :cvv, numericality: { only_integer: true }, format: { with: /\A[0-9]{3,4}\Z/ }

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
      card = CreditCard.where(order_id: order).first_or_initialize
      card.update_attributes!(attributes)
    end
  end
end
