source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#Rails database
gem 'mysql2', "0.3.6"

# Rails 3.1 - Pagination - Use the head for rails 3.1
gem 'kaminari', :git => "git://github.com/amatsuda/kaminari.git"

# Asset template engines
gem 'json'
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'feedzirra'

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', "2.6.0"
gem 'capistrano-ext' # Extend capistrano to multiple environments

# To use debugger
# gem 'ruby-debug'

# Rails 3.1 - Image - Use the head for rails 3.1
#gem 'rmagick' # Image Manipulation
#gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git" # Image Database
#gem 'aws-s3', :require => 'aws/s3' # Image Storage

# Search Engine
gem 'thinking-sphinx', :branch => "rails3", :git => "git://github.com/freelancing-god/thinking-sphinx.git", :require => 'thinking_sphinx'


# Authentication
# Decided to not go with restful authentication as it's not RAILS 3 by default
# gem 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication'
# Instead using devise

gem 'devise'
gem 'cancan'


#Test gems
gem "rspec-rails", :group => [:test, :development]
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
end