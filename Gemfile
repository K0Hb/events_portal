source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# base gems
gem "puma", "~> 5.0"
ruby "3.0.0"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"

# default gems
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails", '~> 1.0.0'
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# my gems
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.1.3'
gem 'carrierwave'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'hotwire-rails', '~> 0.1.3'
gem 'image_processing'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-vkontakte'
gem 'omniauth-yandex'
gem 'pundit'
gem 'rails-i18n'
gem 'rmagick'
gem 'russian'
gem 'twitter-bootstrap-rails'
gem 'vips'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'sqlite3', '~> 1.4'
  gem 'web-console'
end

group :production do
  gem 'pg'
end
