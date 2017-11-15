require_dependency 'draper'
require_dependency 'bs_checkout/application_decorator'

module BsCheckout
  class OrderItemDecorator < ApplicationDecorator
    def quantity_field(field, item)
      if checkout_index_page?
        h.render partial: 'bs_checkout/checkout/quantity_field', locals: { field: field, item: item }
      else
        h.content_tag(:p, model.quantity)
      end
    end

    def delete_button(item)
      if checkout_index_page?
        h.content_tag :td do
          span = h.content_tag(:span, '&times;'.html_safe, 'aria-hidden': 'true')
          attributes = delete_button_attributes(item)
          h.content_tag(:a, span, attributes)
        end
      end
    end

    def show_subtotal
      model.quantity * model.product.price
    end

    private

    def delete_button_attributes(item)
      link_class = 'close general-cart-close'
      link = context.order_item_path(item.id)
      attributes = { 'aria-label': 'Close', 'method': 'delete' }
      { class: link_class, href: link, data: attributes }
    end
  end
end
