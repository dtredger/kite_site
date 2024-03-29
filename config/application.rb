require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KiteSite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Autoload paths are added to $LOAD_PATH by default. However, Zeitwerk uses
    # absolute file names internally, and your application should not issue
    # require calls for autoloadable files, so those directories are actually
    # not needed there. You can opt-out with this flag:
    config.add_autoload_paths_to_load_path = false

    # Setting Rails.application.config.active_storage.replace_on_assign_to_many to true
    # will overwrite any existing values (purging the old ones)
    # setting it to false will append the new values.
    config.active_storage.replace_on_assign_to_many = false

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
