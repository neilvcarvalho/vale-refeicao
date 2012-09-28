source 'http://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Assets
gem 'coffee-rails', '~> 3.2.1'
gem 'jquery-rails'

# Autenticação e autorização
gem 'omniauth'
gem 'omniauth-facebook'
gem 'cancan'

# Tools
gem 'twitter-bootstrap-rails'
gem 'nokogiri'
gem 'haml'

# Database
gem 'pg'
gem 'foreigner'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end

# Testes
group :development, :test do
	gem 'growl', require: (RUBY_PLATFORM.include?('darwin') ? 'growl' : false)
	gem 'rspec-rails', '~> 2.6'
	gem 'guard-rspec'
	gem 'machinist'
	gem 'capybara-webkit'
	gem 'shoulda-matchers'
	gem 'spork'
	gem 'guard-spork'
	gem 'guard-cucumber'
end

group :test do
	gem 'cucumber-rails', require: false
	gem 'database_cleaner'
	gem 'turn', :require => false
end

# Heroku
gem 'heroku'
gem 'thin'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
