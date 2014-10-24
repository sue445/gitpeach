source 'https://rubygems.org'

# uncomment out when deploy to Heroku
# ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Support DBs
gem 'mysql2', "~> 0.3.15",  group: :mysql
gem 'pg', group: :postgres

gem "avatar", "~> 0.2.0"
gem 'coffee-rails', '~> 4.0.1'
gem "friendly_id", "~> 5.0.3"
gem "gitlab", "~> 3.2.0"
gem 'jbuilder', '~> 2.2.3'
gem 'jquery-rails', "~> 3.1.2"
gem "jquery-ui-rails", "~> 5.0.2"
gem "less-rails", "2.5.0"
gem "libv8", "~> 3.16.14.7"
gem 'pusher', "~> 0.14.2"
gem 'sass-rails', '~> 4.0.3'
gem "slim-rails", "~> 2.1.5"
gem "therubyracer", "~> 0.12.1", platform: :ruby
gem "twitter-bootstrap-rails", github: "seyhunak/twitter-bootstrap-rails", branch: "bootstrap3", ref: "128f37"
gem 'uglifier', '~> 2.5.3'

group :development do
  gem "annotate", "~> 2.6.5", require: false
  gem "better_errors", '~> 2.0.0'
  gem "binding_of_caller"
  gem "net-http-spy"
  gem "pry"       , "~> 0.10.1"  , group: :test
  gem "pry-remote", "~> 0.1.8"   , group: :test
  gem "pry-nav"   , "~> 0.2.4"   , group: :test
  gem "pry-rails" , "~> 0.3.2"   , group: :test
  gem "view_source_map", "0.1.0"
end

group :test do
  gem 'coveralls', '~> 0.7.1', require: false
  gem "database_rewinder", "~> 0.4.1"
  gem "factory_girl_rails", "~> 4.5.0", group: :development
  gem "rspec-collection_matchers", "~> 1.0.0"
  gem "rspec-its", "1.0.1"
  gem "rspec-parameterized", "~> 0.1.2"
  gem "rspec-rails", "~> 3.1.0", group: :development
  gem "webmock", "~> 1.20.0"
end

group :production do
  gem "rails_12factor", "0.0.3"
  gem "unicorn", "~> 4.8.3"
end
