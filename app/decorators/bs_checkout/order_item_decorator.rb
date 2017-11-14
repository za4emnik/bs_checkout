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
          h.content_tag(:a, h.content_tag(:span, '&times;'.html_safe, 'aria-hidden': 'true'), class: 'close general-cart-close', href: context.order_item_path(item.id), 'aria-label': 'Close', 'data-method': 'delete')
        end
      end
    end

    def show_subtotal
      model.quantity * model.product.price
    end
  end
end
