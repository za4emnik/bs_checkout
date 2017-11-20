module BsCheckout
  class AddressBuildForm
    include ActiveModel::Model
    include Virtus.model

    attribute :first_name, String
    attribute :last_name, String
    attribute :address, String
    attribute :city, String
    attribute :zip, Integer
    attribute :country_id, Integer
    attribute :phone, String

    validates :first_name, :last_name, :address, :city, :zip, :phone, :country_id, presence: true
    validates :first_name, :last_name, :city, format: { with: /[A-Z][a-z]/ }
    validates :first_name, :last_name, :city, length: { maximum: 50 }
    validates :zip, numericality: { only_integer: true }
    validates :phone, length: { maximum: 21 }
    validates :phone, format: { with: /\A[\+]([0-9]){11,}\Z/, message: I18n.t('errors.phone_error') }

    def save
      if valid?
        true
      else
        false
      end
    end
  end
end
