require_dependency 'draper'
require_dependency 'bs_checkout/application_decorator'

module BsCheckout
  class OrderDecorator < ApplicationDecorator
    decorates_association :order_items

    def summary_coupon
      if model.coupon
        h.content_tag :tr do
          h.concat h.content_tag(:td, h.content_tag(:p, I18n.t(:coupon), class: 'font-16'))
          h.concat h.content_tag(:td, h.content_tag(:p, "€#{model.coupon.value}", class: 'font-16'))
        end
      end
    end

    def summary_delivery
      if model.delivery
        h.content_tag :tr do
          h.concat h.content_tag(:td, h.content_tag(:p, I18n.t(:shipping), class: 'font-16'))
          h.concat h.content_tag(:td, h.content_tag(:p, "€#{model.delivery.price}", class: 'font-16'))
        end
      end
    end

    def delete_button_header
      h.content_tag(:th, '', class: 'col-close') if checkout_index_page?
    end

    def show_total
      model.total.positive? ? model.total : 0
    end

    def render_shipping_address
      object = if model.try(:shipping_address).try(:use_billing_address) || !model.shipping_address
                 model.billing_address
               else
                 model.shipping_address
               end
      h.render partial: '/bs_checkout/checkout/address', locals: { obj: object }
    end

    def filtred_cart_number
      if model.cart.try(:number)
        stars = '*' * (model.cart.number.length - 4)
        stars.concat(model.cart.number.last(4))
      end
    end

    def show_order_title
      h.current_user.orders.any? ? I18n.t(:my_orders) : I18n.t(:no_orders)
    end
  end
end
