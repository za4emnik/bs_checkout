class ApplicationController < ActionController::Base
  helper BsCheckout::ApplicationHelper
  protect_from_forgery with: :null_session
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to main_app.root_path, notice: exeption.message
  end

  private

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
