class Subscription < ApplicationRecord
  REGEX_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  belongs_to :event
  belongs_to :user, optional: true

  before_validation :email_downcase

  with_options unless: -> { user.present? } do |user|
    user.validates :user_name, presence: true
    user.validates :user_email, presence: true, format: REGEX_EMAIL, uniqueness: { scope: :event_id }
    user.validate :email_presence
  end

  with_options if: -> { user.present? } do |user|
    user.validates :user, uniqueness: { scope: :event_id }
  end

  validate :yourself_subscribe

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def email_presence
    errors.add(:user_email, :taken) if User.find_by(email: user_email)
  end

  def email_downcase
    user_email.downcase! if user_email.present?
  end

  def yourself_subscribe
    errors.add(:user, I18n.t('subscriptions.subscription.yourself_subscription')) if event.user == user
  end
end
