source 'http://ruby.taobao.org'
ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
gem 'bootstrap-will_paginate'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'mysql2', '0.3.13'
gem 'rolify'
gem 'simple_form', '>= 3.0.0.rc'

# For linux
# group :assets do
#   gem 'therubyracer', :platform=>:ruby
# end
# gem 'puma'

#Excel processing
gem 'roo', '>=1.11.2' 
gem 'rubyzip', "~> 0.9.9" #fix the error: cannot load such file -- zip/zipfilesystem

#Wizard
gem 'wicked'
#File upload
gem 'paperclip'
gem 'paperclip-qiniu'

#I18n
gem 'rails-i18n', '~> 4.0.0.pre' # For 4.0.x
gem 'i18n_yaml_generator'

#Queue
gem 'sidekiq'

gem "nokogiri"
gem "htmlentities"
gem 'slodown'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end

