class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  before_validation :email_downcase

  validate :email_check_in_users, unless: -> { user.present? }
  validates :event, presence: true

  # проверки выполняются только если user не задан (незареганные приглашенные)
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true,
            format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
            uniqueness: {scope: :event_id},
            unless: -> { user.present? }

  # для данного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  validate :user_current?


  # переопределяем метод, если есть юзер, выдаем его имя,
  # если нет -- дергаем исходный переопределенный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # переопределяем метод, если есть юзер, выдаем его email,
  # если нет -- дергаем исходный переопределенный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def email_check_in_users
    errors.add(:user_email, :alien_email) if User.find_by(email: user_email)
  end

  def email_downcase
    user_email.downcase! if user_email.present?
  end

  def user_current?
    if event.user.eql?(user)
      errors.add(:user, I18n.t('subscriptions.subscription.yourself_subscription'))
    end
  end
end
