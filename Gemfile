source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


gem "puma", "~> 5.0"
ruby "3.0.0"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"


gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails", '~> 1.0.0'
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

#гемы которые я добавил
gem 'devise'
gem 'bootstrap', '~> 5.1.3'
gem "bootsnap", require: false
gem 'twitter-bootstrap-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
  gem "web-console"
end

group :production do
  gem 'pg'
end
