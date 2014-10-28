module SpreeZoned
  module ActiveZone
    class Session
      @@key = :spree_zoned_active_zone_store

      def self.begin_session(cookie_jar)
        s = CookieSession.new(cookie_jar)
        Thread.current[@@key] = s
      end

      def self.end_session
        Thread.current[@@key] = nil
      end

      def self.current
        # Return the open session, or a session that will always return the default zone.
        # Returning the default zone avoids Null errors in contexts that don't have
        # a session, e.g. rake scripts.
        return Thread.current[@@key] || DefaultZoneSession.new
      end
    end
  end
end
