source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
# 'bootstrap-sass'
gem 'bootstrap-sass'
# 'bcrypt-ruby'
gem 'bcrypt-ruby'
#Postgresql
gem 'pg'
#JQuery Input Mask to add masks for inputs
gem 'jquery-inputmask-rails'
#Friendly_id to mask URLs
gem 'friendly_id'
#Carrierwave to load images
gem 'carrierwave'
#Whenever for tasks
gem 'whenever', require: false
#Webrick
gem 'webrick'
#SimpleForm - Forms Otimization
gem 'simple_form'
# Customize Confirm Popups 
gem 'twitter-bootstrap-rails-confirm'

#Dependencies for Test and Development
group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rubycritic'
  gem 'simplecov', :require => false
end

#Dependencies for Tests
group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'capybara-screenshot'
  gem 'poltergeist'
  gem "launchy"
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem "codeclimate-test-reporter", require: nil
end
