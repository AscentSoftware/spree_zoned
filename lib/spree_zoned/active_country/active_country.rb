module SpreeZoned
  class ActiveCountry
    def self.get(cookies)
      country_id = cookies[:spree_zoned_country]
      active_country = Spree::Country.find_by(id: country_id)
      return active_country
    end

    def self.set(cookies, country)
      if country.nil?
        cookies.delete(:spree_zoned_country, domain: :all)
        return
      end

      cookies[:spree_zoned_country] = {
        domain: :all,
        expires: 1.year.from_now,
        value: country.id
      }
    end
  end
end
