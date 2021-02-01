require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KiteSite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures:         false,
                       view_specs:       false,
                       helper_specs:     false,
                       routing_specs:    false,
                       request_specs:    false,
                       controller_specs: true
    end

    # TODO: re-enable when using API. limit in production context
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #      origins '*'
    #      resource '*', headers: :any,
    #                    expose: '*',
    #                    # expose: %w(access-token expiry content-type token-type uid client),
    #                    methods: [:get, :post, :put, :options, :delete]
    #    end
    # end
  end
end
