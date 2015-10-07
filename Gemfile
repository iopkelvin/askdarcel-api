source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.4'
gem 'rails-api', '~> 0.4.0'
gem 'rails_12factor'
gem 'rack-cors', '~> 0.4', require: 'rack/cors'

gem 'kaminari', '~> 0.16.3'
gem 'active_model_serializers',
    '0.10.0.rc3',
    git: 'https://github.com/rails-api/active_model_serializers.git' # Need pagination
gem 'activerecord-postgis-adapter', '~> 3.0.0'
gem 'rgeo', github: 'rgeo/rgeo'

gem 'phone', '~> 1.3.0.beta1'
gem 'geocoder', '~> 1.2.9'
gem 'paperclip', '~> 4.3'
gem 'aws-sdk', '< 2'

gem 'pg', '~> 0.18.3'

gem 'faraday'

gem 'spring', group: :development

group :development, :test do
  gem 'apivore', git: 'https://github.com/westfieldlabs/apivore.git'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails', '~> 3.0'
  gem 'rubocop'
end
