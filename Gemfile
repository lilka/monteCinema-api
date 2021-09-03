# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use gem devise
gem 'devise', '~> 4.2'
gem 'devise_token_auth', '~> 1.2.0'
gem 'omniauth', '~> 2.0.4'
gem 'sidekiq', '~> 4.1', '>= 4.1.2'
gem "sidekiq-cron", "~> 1.1"
gem 'pundit', '~> 1.1'


# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.18', '>=2.18.0'
  gem 'figaro', '~> 1.1', '>= 1.1.1'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop', '~> 1.18', '>= 1.18.4'
  gem 'sentry-rails', '~> 4.3', '>= 4.3.3'
  gem 'sentry-ruby', '~> 4.6', '>= 4.6.4'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'simplecov', '~> 0.21.0', require: false

end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
