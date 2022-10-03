source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# base gems
gem 'puma', '~> 5.0'
ruby '3.0.0'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

# default gems
gem 'importmap-rails'
gem 'jbuilder'
gem 'stimulus-rails'
gem 'sprockets-rails'
gem 'turbo-rails', '~> 1.0.0'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

# my gems
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'bootstrap'
gem 'carrierwave'
gem 'cssbundling-rails', '~> 1.1'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'hotwire-rails', '~> 0.1.3'
gem 'image_processing'
gem 'jsbundling-rails', '~> 1.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-vkontakte', '~> 1.6.0'
gem 'omniauth-yandex'
gem 'pundit'
gem 'rails-i18n'
gem 'rmagick'
gem 'russian'
gem 'sass-rails'
gem 'vips'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'factory_bot_rails'
end

group :production do
  gem 'pg'
end
