require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RainService
  class Application < Rails::Application

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      
      
      g.view_specs false
      g.helper_specs false
    end

    #auto load extras
    config.autoload_paths += %W(#{config.root}/extras)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    #xj: I found out that for i18n to work with cache_classes set to true i have to declare this in application.rb or respective environment.rb
    # fix that nasty i18n bug!
    config.before_configuration do
      I18n.locale = "zh-CN".to_sym
      I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
      I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
      I18n.reload!
    end
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = ['zh-CN', :en]

    config.i18n.default_locale = "zh-CN".to_sym

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
  end
end
