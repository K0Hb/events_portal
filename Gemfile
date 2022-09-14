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
gem 'devise'
gem 'bootstrap', '~> 5.1.3'
gem "bootsnap", require: false
gem 'twitter-bootstrap-rails'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'russian'
gem 'carrierwave'
gem 'image_processing'
gem 'rmagick'
gem 'vips'
gem "hotwire-rails", "~> 0.1.3"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
  gem "web-console"
end

group :production do
  gem 'pg'
end
