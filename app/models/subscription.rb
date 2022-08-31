class Subscription < ApplicationRecord
  REGEX_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  belongs_to :event
  belongs_to :user, optional: true

  before_validation :email_downcase

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: REGEX_EMAIL, uniqueness: { scope: :event_id }
    validate :email_suitability
  end

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :yourself_subscribe
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def email_suitability
    errors.add(:user_email, :taken) if User.find_by(email: user_email)
  end

  def email_downcase
    user_email&.downcase!
  end

  def yourself_subscribe
    errors.add(:user, :taken) if event.user == user
  end
end
