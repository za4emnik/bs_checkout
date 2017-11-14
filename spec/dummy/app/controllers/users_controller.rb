class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_variables, only: %i[edit update]
  load_and_authorize_resource

  def update
    if update_user_data
      flash[:success] = I18n.t(:settings_successfully_saved)
      redirect_to(settings_path)
    else
      render(:edit)
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  def update_user_data
    if params.include?('addresses')
      update_addresses
    elsif params.include?('email_form')
      update_email
    elsif params.include?('password_form')
      update_password
    end
  end

  def update_addresses
    billing = update_billing if values_present?('billing_form')
    shipping = update_shipping if values_present?('shipping_form')
    billing || shipping
  end

  def values_present?(type)
    params['addresses']&.[](type)&.values&.any?(&:present?)
  end

  def update_billing
    @billing_address = BillingForm.new(address_params(:billing_form).to_h)
    if @billing_address.valid?
      current_user.build_billing_address unless current_user.billing_address
      current_user.billing_address.update_attributes(address_params(:billing_form))
    end
  end

  def update_shipping
    @shipping_address = ShippingForm.new(address_params(:shipping_form).to_h)
    if @shipping_address.valid?
      current_user.build_shipping_address unless current_user.shipping_address
      current_user.shipping_address.update_attributes(address_params(:shipping_form))
    end
  end

  def update_email
    current_user.update_email(params[:email_form][:email])
  end

  def update_password
    bypass_sign_in(current_user) if current_user.update(password_params)
  end

  def set_variables
    @billing_address = BillingForm.new(get_attributes('billing_address'))
    @shipping_address = ShippingForm.new(get_attributes('shipping_address'))
  end

  def get_attributes(type)
    current_user.public_send(type)&.attributes
  end

  def address_params(type)
    address = params.require('addresses').require(type)
    address.permit(:first_name, :last_name, :address, :city, :zip, :country_id, :phone)
  end

  def password_params
    params.require(:password_form).permit(:password, :password_confirmation)
  end
end
