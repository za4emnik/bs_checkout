module BsCheckout
  class StepShowService
    def initialize(step, order, session)
      @step = step
      @order = order
      @session = session
      @obj = if order.billing_address && order.shipping_address
               order.decorate
             else
               order.user
             end
    end

    def form
      public_send(@step.to_s) if respond_to? @step.to_s
    end

    def address
      form = AddressForm.new(obj: @obj)
      form.billing_address = address_attributes(:billing_address)
      form.shipping_address = address_attributes(:shipping_address)
      form
    end

    def delivery
      Delivery.all
    end

    def payment
      @order.cart ||= Cart.new
      form = CartForm.new(@order.cart.attributes)
      form.order = @order
      form
    end

    def confirm
      @session[:steps_taken?] = true
      @obj
    end

    def complete
      order = @order.user.orders.where.not(aasm_state: 'pending').order(:created_at).last
      order.decorate if order.present?
    end

    private

    def address_attributes(type)
      if @obj.public_send(type)
        @obj.public_send(type).attributes
      else
        @obj.public_send("build_#{type}".to_sym).attributes
      end
    end
  end
end
