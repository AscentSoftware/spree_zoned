module SpreeZoned
  class ActiveZone
    def self.get(cookies)
      zone_id = cookies[:spree_zoned_zone]
      active_zone = Spree::Zone.find_by(id: zone_id)
      return active_zone
    end

    def self.set(cookies, zone)
      cookies[:spree_zoned_zone] = {
        domain: :all,
        expires: 1.year.from_now,
        value: zone.id
      }
    end
  end
end
