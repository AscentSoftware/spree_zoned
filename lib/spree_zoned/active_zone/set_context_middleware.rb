# Todo replace with library requires.
require_relative 'active_zone_context'
require_relative 'active_zone'

module SpreeZoned
  class SetContextMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      z = ActiveZone.get(request.cookie_jar) || Spree::Zone.default # TODO: Refactor (and fix any other places)
      logger.debug("Request zone set to #{z.name}.")
      ActiveZoneContext.set(z)
      @app.call(env)
    ensure
      ActiveZoneContext.clear
    end

    def logger
      Rails.logger
    end
  end
end
