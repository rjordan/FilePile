source 'https://rubygems.org'

gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


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

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'mongoid'
gem 'mongoid_grid'
gem 'bson_ext'
gem 'rack-gridfs', :require=>'rack/gridfs'
gem 'rabl'

group :development do
  gem 'thin'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'jasminerice'
end

group :test do
  gem 'turn', :require => false
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'cucumber-rails'
  gem 'capybara'
  #gem 'database_cleaner'
end

gem 'spine-rails'
gem 'smt_rails'
