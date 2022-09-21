class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def yandex
    @user = User.find_for_github_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Yandex')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Github',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Github')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Github',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Facebook',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  def vkontakte
    @user = User.find_for_vkontakte_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Vkontakte')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Vkontakte',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
end