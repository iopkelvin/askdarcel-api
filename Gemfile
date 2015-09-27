source 'https://rubygems.org'

ruby "2.2.2"

gem 'rails', '4.2.4'
gem 'rails-api', '~> 0.4.0'
gem 'rails_12factor'
gem 'rack-cors', '~> 0.4', require: 'rack/cors'

gem 'kaminari', '~> 0.16.3'
gem 'active_model_serializers', git: 'https://github.com/rails-api/active_model_serializers.git' # Need pagination in HEAD
gem 'phone', '~> 1.3.0.beta1'
gem 'geocoder', '~> 1.2.9'
gem "paperclip", "~> 4.3"
gem 'aws-sdk', '< 2'

gem 'pg', '~> 0.18.3'

gem 'faraday'

gem 'spring', group: :development

group :development, :test do
  gem 'apivore'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails', '~> 3.0'
end
