source 'https://rubygems.org'

gem 'dotenv-rails'

gem 'rails', '4.2.0'

gem 'rails-api'

gem 'spring', :group => :development

gem 'pg'

# serializer
gem 'active_model_serializers'

gem 'devise'
gem 'oauth2'

gem "simple_token_auth", "0.0.3", git: "https://github.com/he9qi/simple_token_auth.git"
gem "simple_mobile_oauth", "0.0.2", git: "https://he9qi@bitbucket.org/he9qi/simple_mobile_oauth.git"

# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'turnip'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'database_cleaner', '~> 1.2.0'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
end
