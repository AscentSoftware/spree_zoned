module SpreeZoned
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_zoned'

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "active_zone/**/*.rb")) do |c|
        require(c)
      end

      ['../../app/**/*_decorator*.rb', '../../lib/**/*_decorator*.rb'].each do |path|
        Dir.glob(File.join(File.dirname(__FILE__), path)) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/spree_zoned/**/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "spree_zoned.override_currency", before: "spree.environment" do
      # Override the AppConfiguration class before Spree initialises it.
      # The changes to the class don't get replicated into Spree::Config
      # unless the decorator is loaded before the class is initialised.
      # I'm not sure why.
      c = File.join(File.dirname(__FILE__), '../../app/models/spree/app_configuration_decorator.rb')
      Rails.configuration.cache_classes ? require(c) : load(c)
    end
  end
end
