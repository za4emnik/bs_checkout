require_dependency 'bs_checkout/application_controller'
require_dependency 'wicked'
require_dependency 'haml'

module BsCheckout
  class CheckoutController < ApplicationController
    include Wicked::Wizard
    before_action :assign_order_to_user
    before_action :authenticate_user!, except: :index
    before_action :check_order, only: :show

    steps :address, :delivery, :payment, :confirm, :complete

    def index
      current_order.subtotal!
      current_order.update_total!
    end

    def show
      @form = StepShowService.new(step, current_order, session).form
      render_wizard
    end

    def update
      @form = StepUpdateService.new(step, current_order, params, session).update
      render_page
    end

    def update_cart
      authorize! :manage, current_order
      update_items
      check_coupon if params[:order]&.[](:coupon).present?
      redirect_back(fallback_location: root_path)
    end

    private

    def render_page
      if need_redirect?
        jump_to(:confirm)
        render_wizard
      else
        @form ? render_wizard(@form) : render_wizard(current_order)
      end
    end

    def need_redirect?
      session[:steps_taken?] &&
        step != :confirm &&
        (@form ? @form.valid? : true)
    end

    def finish_wizard_path
      main_app.root_path
    end

    def assign_order_to_user
      unless current_order.user
        current_order.user = current_user
        current_order.save
      end
    end

    def check_order
      unless %i[complete wicked_finish].include?(step.to_sym)
        redirect_to(checkout_index_path) if current_order.order_items.blank?
      end
    end

    def check_coupon
      coupon = Coupon.where(code: params[:order][:coupon], active: true).first
      if coupon
        coupon.active = false
        current_order.coupon = coupon
      end
      flash[:error] = I18n.t(:coupon_not_found) unless coupon
    end

    def update_items
      params[:order_items]&.each do |key|
        if order_items_params(key)[:quantity].to_i.positive?
          OrderItem.update(key, order_items_params(key))
        end
      end
    end

    def order_items_params(item)
      params.require(:order_items).require(item).permit(:quantity)
    end
  end
end
