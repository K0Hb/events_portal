class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[github yandex vkontakte] # facebook vkontakte dont work :(

  mount_uploader :avatar, AvatarUploader

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  validates :name, presence: true, length: {maximum: 35}

  validates :email, length: {maximum: 255}
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  after_commit :link_subscriptions, on: :create

  def self.find_or_create_for_oauth(access_token)
    provider = access_token.provider
    name = access_token.info.name
    email = access_token.info.email
    image = access_token.info.image
    url = get_url_from_access_token(access_token)

    user = find_by(email: email)

    return user if user.present?

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = name
      user.email = email
      user.password = Devise.friendly_token.first(16)
      user.url = url

      begin
        user.remote_avatar_url = image
      rescue NoMethodError
        Rails.logger.info 'Failed to upload user photo'
      end
    end
  end

  private

  def self.get_url_from_access_token(access_token)
    urls = {
      yandex: "https://yandex/#{access_token.info.name}",
      github: access_token.info.urls['GitHub'],
      vkontakte: access_token.info.urls['Vkontakte']
    }
    urls[access_token.provider.to_sym]
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
