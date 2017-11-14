module BsCheckout
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    helper_method :current_order

    def current_order
      return @current_order if @current_order
      @current_order = order
      session[:order_id] = @current_order.id
      @current_order
    end

    private

    def order
      BsCheckout::Order.where(id: session[:order_id], aasm_state: 'pending').first || BsCheckout::Order.create!
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end
  end
end
