module SpreeZoned
  module ActiveZone
    class Session
      @@key = :spree_zoned_active_zone_store

      def self.begin_session(cookie_jar)
        s = Session.new(cookie_jar)
        Thread.current[@@key] = s
      end

      def self.end_session
        Thread.current[@@key] = nil
      end

      def self.current
        return Thread.current[@@key]
      end

      def initialize(cookie_jar)
        @cookie_jar = cookie_jar
      end

      def get
        if @current_zone
          return @current_zone
        end

        @current_zone = CookieStore.get(@cookie_jar)
        return @current_zone
      end

      def get_or_default
        z = get
        unless z
          @current_zone = z = Spree::Zone.default
        end
        return z
      end

      def set(zone)
        @current_zone = zone
        CookieStore.set(@cookie_jar, zone)
      end
    end
  end
end
