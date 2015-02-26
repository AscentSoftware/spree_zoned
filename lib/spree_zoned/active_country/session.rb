module SpreeZoned
  module ActiveCountry
    class Session
      @@key = :spree_zoned_active_country_store

      def self.begin_session(cookie_jar)
        s = CookieSession.new(cookie_jar)
        Thread.current[@@key] = s
      end

      def self.end_session
        Thread.current[@@key] = nil
      end

      def self.current
        # Return the open session, or a session that will always return nil.
        # Returning a nil session avoids nil errors in contexts that don't have
        # a session, e.g. rake scripts.
        return Thread.current[@@key] || NilSession.new
      end
    end
  end
end
