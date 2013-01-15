source 'https://rubygems.org'

gem 'rails', '~> 3.2.1'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'mongoid', '~> 2.4'
gem 'mongoid_grid'
gem 'bson_ext'
gem 'rack-gridfs', :require=>'rack/gridfs'
gem 'rabl'
gem 'jquery-fileupload-rails'

group :development do
  gem 'thin'
  gem 'awesome_print'
  gem 'wirble'
  gem 'looksee'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'jasminerice'
  gem 'guard-jasmine'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'phantomjs'
  gem 'rb-inotify'
end

group :test do
  gem 'turn', :require => false
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'cucumber-rails', :require=>false
  gem 'capybara'
  #gem 'database_cleaner'
end

gem 'spine-rails'
gem 'smt_rails'
