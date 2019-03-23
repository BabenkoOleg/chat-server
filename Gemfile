source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Annotate Rails classes with schema and routes info
gem 'annotate'
# A lightning fast JSON:API serializer for Ruby Objects
gem 'fast_jsonapi'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # A runtime developer console and IRB alternative with powerful introspection capabilities
  gem 'pry-rails'
  # Pretty print your Ruby objects with style - in full color and with proper indentation
  gem 'awesome_print'
  # A library for setting up Ruby objects as test data
  gem 'factory_bot_rails'
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Testing framework for Rails 3.x, 4.x and 5.x.
  gem 'rspec-rails'
  # Simple one-liner tests for common Rails functionality
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
  # Strategies for cleaning databases in Ruby
  gem 'database_cleaner'
  # Code coverage with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', require: false
  # RSpec progress bar formatter
  gem 'fuubar'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
