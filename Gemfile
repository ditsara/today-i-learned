source "https://rubygems.org"

ruby "3.2.2"

##### Rails framework

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "~> 3.4.2"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"
# Nope, need PostgreSQL so we can use indexing features in Ancestry
gem "pg", "~> 1.5.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 1.2.1"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 1.5.0"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.11.5"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", "~> 2.0.6", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.16.0", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.8.0", platforms: %i[ mri windows ]

  # Use factories instead of fixtures
  gem "factory_bot_rails", "~> 6.2.0"

  # Bring back white/grey-box testing [https://github.com/rails/rails-controller-testing]
  gem 'rails-controller-testing', "~> 1.0.5"

  # Generate (sort-of) realistic sample data [https://github.com/faker-ruby/faker]
  gem 'faker', "~> 3.2.1"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "~> 4.2.1"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", "~> 3.39.2"
  gem "selenium-webdriver", "~> 4.14.0"
  gem 'simplecov', require: false
end

##### Application

gem 'sorcery', "~> 0.16.5" # auth [https://github.com/sorcery/sorcery]
gem 'slim-rails', "~> 3.6.2" # html templating [https://slim-template.github.io]
gem 'ancestry', "~> 4.3.3" # tree structured content (eg, replies) [https://github.com/stefankroes/ancestry]
gem 'kaminari', "~> 1.2.2" # auto-pagination [https://github.com/kaminari/kaminari]
gem 'redcarpet', "~> 3.6.0" # Markdown rendering, for all user content [https://github.com/vmg/redcarpet]
gem 'pundit', "~> 2.3.1" # Simple authorization framework
