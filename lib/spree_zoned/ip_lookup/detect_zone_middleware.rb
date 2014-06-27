require 'geoip2'
require_relative 'address'

module SpreeZoned::IpLookup
  class DetectZoneMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      set_zone(env)
      @app.call(env)
    end

    def set_zone(env)
      request = ActionDispatch::Request.new(env)
      assigned_zone = SpreeZoned::ActiveZone.get(request.cookie_jar)
      if assigned_zone
        logger.debug("IPLookup: Skipping IP lookup as the visitor is already assigned to the '#{assigned_zone.name}' zone.")
        return
      end

      ip = request.remote_ip

      c = Geoip2.country(ip)
      if c.code || c.error
        logger.warn("IPLookup: Maxmind's API returned an error when looking up IP #{ip}: '#{c.code}', '#{c.error}'")
        return
      end

      spree_country = Spree::Country.find_by(name: c.country.names.en)
      if spree_country.nil?
        logger.warn("IPLookup: The country returned by geoip2 #{c.country.names.en} did not match any countries in Spree.")
        return
      end

      z = Spree::Zone.match(Address.new(spree_country.id))
      if z.nil?
        logger.warn("IPLookup: Unable to match the country #{spree_country.id} #{spree_country.name} to a zone.")
        return
      end

      logger.debug("IPLookup: Matched the IP #{ip} to the #{z.name} zone.")
      SpreeZoned::ActiveZone.set(request.cookie_jar, z)
    end

    def logger
      Rails.logger
    end
  end
end
