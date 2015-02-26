module SpreeZoned
  module ActiveCountry
    class CookieStore
      @@cookie_key = :spree_zoned_country

      def self.get(cookies)
        country_id = cookies[@@cookie_key]
        active_country = Spree::Country.find_by(id: country_id)
        return active_country
      end

      def self.set(cookies, country)
        if country.nil?
          cookies.delete(@@cookie_key)
          return
        end

        cookies[@@cookie_key] = {
          expires: 1.year.from_now,
          value: country.id
        }
      end
    end
  end
end
