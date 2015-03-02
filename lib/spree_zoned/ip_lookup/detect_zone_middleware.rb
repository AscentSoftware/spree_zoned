require 'geoip2'
require_relative 'address'
require 'browser'

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
      browser = Browser.new(
        ua: request.user_agent,
        accept_language: request.env["HTTP_ACCEPT_LANGUAGE"]
      )

      if browser.bot?
        logger.debug("IPLookup: Skipping IP lookup as the visitor is a bot. Their user-agent string is '#{request.user_agent}'.")
        return
      end

      assigned_zone = SpreeZoned::ActiveZone::Session.current.get
      if assigned_zone
        logger.debug("IPLookup: Skipping IP lookup as the visitor is already assigned to the '#{assigned_zone.name}' zone.")
        return
      end

      ip = ENV['SPREE_ZONED_REMOTE_IP_OVERRIDE'] || request.remote_ip

      c = Geoip2.country(ip)
      if c.code || c.error
        logger.warn("IPLookup: Maxmind's API returned an error when looking up IP #{ip}: '#{c.code}', '#{c.error}'")
        return
      end

      spree_country = Spree::Country.find_by(iso: c.country.iso_code)
      if spree_country.nil?
        logger.warn("IPLookup: The country returned by geoip2 #{c.country.names.en} iso:#{c.country.iso_code} did not match any countries in Spree.")
        return
      end

      SpreeZoned::ActiveCountry::Session.current.set(spree_country)

      z = Spree::Zone.match(Address.new(spree_country.id))
      if z.nil?
        logger.warn("IPLookup: Unable to match the country #{spree_country.id} #{spree_country.name} to a zone.")
        return
      end

      logger.debug("IPLookup: Matched the IP #{ip} to the country '#{spree_country}' in the '#{z.name}' zone.")
      SpreeZoned::ActiveZone::Session.current.set(z)
    rescue => e
      logger.error "IPLookup: Exception occured during ip lookup: #{e}"
    end

    def logger
      Rails.logger
    end
  end
end
