class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[github yandex vkontakte] # facebook vkontakte dont work :(

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  validates :name, presence: true, length: {maximum: 35}

  validates :email, length: {maximum: 255}
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  after_commit :link_subscriptions, on: :create

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  class << self
    def find_or_create_for_oauth(access_token)
      provider = access_token.provider
      name = access_token.info.name
      email = access_token.info.email
      url = get_url_from_access_token(access_token)
      image = URI.parse(access_token.info.image).open if access_token.info.image

      user = find_by(email: email)

      return user if user.present?

      where(url: url, provider: provider).first_or_create! do |user|
        user.name = name
        user.email = email
        user.password = Devise.friendly_token.first(16)
        user.url = url
        user.avatar.attach(io: image, filename: 'avatar.png') if image
      end
    end

    private

    def get_url_from_access_token(access_token)
      case access_token.provider.to_sym
      when :yandex
        "https://yandex/#{access_token.info.name}"
      when :github
        access_token.info.urls['GitHub']
      when :vkontakte
        access_token.info.urls['Vkontakte']
      end
    end
  end
end
