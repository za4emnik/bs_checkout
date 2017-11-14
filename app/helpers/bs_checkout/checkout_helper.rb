module BsCheckout
  module CheckoutHelper
    def current_step(current_step)
      'active' if current_step == @step
    end

    def checked_delivery?(delivery_id)
      if params[:delivery_id] || current_order.delivery_id
        params[:delivery_id] == delivery_id || current_order.delivery_id == delivery_id
      else
        true
      end
    end
  end
end
