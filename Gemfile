# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg'
gem 'pghero'
gem 'pg_query', '>= 0.9.0'

gem 'rails', '~> 6.1.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# gem 'jsonapi-serializer'
gem 'rack-cors'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'devise'
# gem 'devise_token_auth'
gem 'acts-as-taggable-on'
gem 'friendly_id'
# Use Active Storage variant
gem 'administrate'
gem 'administrate-field-active_storage'
gem 'administrate-field-tag', git: 'git@github.com:herregroen/administrate-field-tag.git'
gem 'image_processing'
gem 'kaminari'
gem 'leaflet-rails'

gem 'acts_as_favoritor'
gem 'cancancan'

# gem 'easy_feedback', path: '../../easy_feedback'

gem 'rollbar'
gem 'strong_migrations'

gem 'aws-sdk-s3', require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'brakeman', require: false
  gem 'factory_bot_rails'
  gem 'guard', require: false
  gem 'guard-brakeman', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false
end

group :development do
  gem 'annotate'
  gem 'awesome_print'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # for rails-panel
  # TODO - causes recursion error in rails 6.1?
  # gem 'meta_request'
  # TODO - install & run mailcatcher to read mails (not part of bundle)
  gem 'unsplash' # for images
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
