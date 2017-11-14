require_dependency 'draper'

module BsCheckout
  class ApplicationDecorator < Draper::Decorator
    delegate_all

    def edit_link
      if context.request.fullpath == context.wizard_path(:confirm)
        h.link_to I18n.t(:edit), h.wizard_path(:address), class: 'general-edit'
      end
    end

    def checkout_index_page?
      context.request.fullpath == context.root_path
    end

    def show_billing_address
      h.render partial: '/bs_checkout/checkout/address', locals: { obj: model.billing_address }
    end

    def show_shipping_address
      if model.shipping_address.use_billing_address
        show_billing_address
      else
        h.render partial: '/bs_checkout/checkout/address', locals: { obj: model.shipping_address }
      end
    end
  end
end
