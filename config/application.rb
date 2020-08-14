require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ExerNote
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Where the I18n library should search for translation files
    config.i18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

    # Permitted locales available for the application
    config.i18n.available_locales = [:sk, :en]

    # Set default locale to something other than :en
    config.i18n.default_locale = :sk

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Add Warden in the middleware stack
    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_strategies :authentication_token
      manager.failure_app = UnauthorizedController
    end
  end
end
