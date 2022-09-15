class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_no_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_can_edit?

  private

  def user_no_authorized
    flash[:alert] = t('pundit.not_authorized')

    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:name, :password, :avatar, :password_confirmation, :current_password]
    )
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:name, :password, :avatar, :password_confirmation, :current_password]
    )
  end

  def current_user_can_edit?(event)
    user_signed_in? && event.user == current_user
  end
end
