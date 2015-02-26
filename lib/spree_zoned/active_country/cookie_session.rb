module SpreeZoned
  module ActiveCountry
    class CookieSession
      def initialize(cookie_jar)
        @cookie_jar = cookie_jar
      end

      def get
        if @current_country
          return @current_country
        end

        @current_country = CookieStore.get(@cookie_jar)
        return @current_country
      end

      def set(country)
        @current_country = country
        CookieStore.set(@cookie_jar, country)
      end
    end
  end
end
