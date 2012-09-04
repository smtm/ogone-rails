# -*- encoding : utf-8 -*-

require 'digest'

require 'ogone-rails/config'
require 'ogone-rails/rails'
require 'ogone-rails/string-to-hash'
require 'ogone-rails/helpers'
require 'ogone-rails/check-auth'

module OgoneRails
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      # Add load paths straight to I18n, so engines and application can overwrite it.
      require 'active_support/i18n'
      I18n.load_path += Dir[File.expand_path('../locales/*.yml', __FILE__)]
    end
  end
end