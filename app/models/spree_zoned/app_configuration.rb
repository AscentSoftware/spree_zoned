module SpreeZoned
  class AppConfiguration < Spree::Preferences::Configuration
    preference :default_zone_id, :integer
  end
end
