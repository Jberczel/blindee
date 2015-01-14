source "https://rubygems.org"
source "https://rails-assets.org"

ruby "2.1.2"

# supsenders base application
gem "airbrake"
gem "bourbon", "~> 3.2.1"
gem "coffee-rails"
gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
gem "jquery-rails"
gem "neat", "~> 1.5.1"
gem "pg"
gem "rack-timeout"
gem "rails", "4.1.4"
gem "recipient_interceptor"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "title"
gem "uglifier"
gem "unicorn"

group :development do
  gem "foreman"
  gem "spring"
  gem "spring-commands-rspec"
  gem "better_errors"
  gem "binding_of_caller" 
  gem "quiet_assets"
  gem "bullet"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 2.14.0"
  gem "letter_opener"
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "newrelic_rpm", ">= 3.7.3"
  gem 'rails_12factor'
end

gem 'devise'
gem 'chart-js-rails'
gem 'haml'
gem 'mandrill_mailer'
gem 'redcarpet'
gem 'font-awesome-sass', '~> 4.2.0'
gem 'icheck-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

