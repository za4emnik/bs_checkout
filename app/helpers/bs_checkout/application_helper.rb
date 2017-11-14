module BsCheckout
  module ApplicationHelper
    def items_in_cart
      OrderItem.where(order_id: session[:order_id]).distinct.count(:product_id)
    end
  end
end
