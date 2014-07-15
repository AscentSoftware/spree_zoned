module SpreeZoned
  class ActiveZoneContext
    def self.get
      return Thread.current[:active_zone]
    end

    def self.set(zone)
      Thread.current[:active_zone] = zone
    end

    def self.clear
      Thread.current[:active_zone] = nil
    end
  end
end
