require_dependency 'bs_checkout/address_build_form'

module BsCheckout
  class ShippingForm < AddressBuildForm
    include ActiveModel::Model
    include Virtus.model

    attribute :use_billing_address, Boolean, default: false

    def invalid?
      use_billing_address ? false : super
    end
  end
end
