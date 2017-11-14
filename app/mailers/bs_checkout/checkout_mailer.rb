module BsCheckout
  class CheckoutMailer < ApplicationMailer
    def order_confirmation(order)
      @order = order
      mail(to: order.user.email, subject: 'Order confirmation')
    end
  end
end
