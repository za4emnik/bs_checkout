module BsCheckout
  class StepUpdateService
    def initialize(step, order, params, session)
      @step = step
      @order = order
      @params = params
      @session = session
    end

    def update
      public_send(@step.to_s) if respond_to? @step.to_s
    end

    def address
      form = AddressForm.new(obj: @order)
      form.billing_address.assign_attributes(address_params(:billing_form))
      form.shipping_address.assign_attributes(address_params(:shipping_form))
      form.save
      form
    end

    def delivery
      form = DeliveryForm.new(current_order: @order, delivery_id: @params[:order][:delivery])
      form.save
      form
    end

    def payment
      form = CreditCardForm.new(credit_card_params.to_h)
      form.order = @order
      form.save
      form
    end

    def confirm
      @order.waiting_processing!
      @session[:steps_taken?] = false
      BsCheckout::CheckoutMailer.order_confirmation(@order).deliver_now
      @order
    end

    private

    def address_params(type)
      params = %i[:first_name, :last_name, :address, :city, :zip, :phone, :country_id, :use_billing_address]
      @params.require(:address_form).require(type).permit(params)
    end

    def credit_card_params
      @params.require(:credit_card_form).permit(:number, :name, :date, :cvv)
    end
  end
end
