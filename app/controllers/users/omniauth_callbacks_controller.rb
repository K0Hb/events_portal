class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user_and_provider

  def yandex
    redirect_after_oauth
  end

  def github
    redirect_after_oauth
  end

  private

  def set_user_and_provider
    @user = User.find_or_create_for_oauth(request.env['omniauth.auth'])
  end

  def redirect_after_oauth
    provider = request.env['omniauth.auth'].provider

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: provider,
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
end
