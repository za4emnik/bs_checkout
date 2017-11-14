module BsCheckout
  class Address < ApplicationRecord
    belongs_to :addressable, polymorphic: true
    belongs_to :country

    def full_name
      "#{first_name} #{last_name}"
    end
  end
end
