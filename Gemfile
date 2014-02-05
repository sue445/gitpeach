source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use mysql as the database for Active Record
gem 'mysql2', "~> 0.3.15"
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', "~> 3.1.0"
gem "jquery-ui-rails", "~> 4.1.1"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "slim-rails", "~> 2.1.0"

# dev tool
group :development do
  gem "annotate", "2.6.0", require: false
  gem "better_errors"
  gem "binding_of_caller"
  gem "view_source_map", "0.0.3"
end

group :test, :development do
  # testing
  gem "rspec-rails", "~> 3.0.0.beta1"
  gem "rspec-collection_matchers", "~> 0.0.2"
  gem "rspec-its", "1.0.0.pre"
  gem "rspec-parameterized", github: "sue445/rspec-parameterized", branch: "rspec-3.0.0.beta1"
  gem "factory_girl_rails", "~> 4.1.0"
  gem "database_rewinder", "~> 0.0.2"

  gem "pry"       , "~> 0.9.12.4"
  gem "pry-remote", "~> 0.1.7"
  gem "pry-nav"   , "~> 0.2.3"
  gem "pry-rails" , "~> 0.3.2"
end

group :test do
  gem "webmock", "~> 1.16.1"
  gem 'coveralls', require: false
end

group :production do
  gem "unicorn", "~> 4.8.1"
end

# twitter-bootstrap-rails
gem "less-rails"
gem "libv8", "~> 3.16.14.3"
gem "twitter-bootstrap-rails", github: "seyhunak/twitter-bootstrap-rails", branch: "bootstrap3"
gem "therubyracer", "~> 0.12.1", platform: :ruby

gem "gitlab", "~> 3.0.0"
gem "avatar", "~> 0.2.0"
gem "friendly_id", "~> 5.0.2"
gem 'pusher'
