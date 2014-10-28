module SpreeZoned
  module ActiveZone
    class CookieSession
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
