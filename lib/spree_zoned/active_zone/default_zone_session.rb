module SpreeZoned
  module ActiveZone
    class DefaultZoneSession
      def get
        return Spree::Zone.default
      end

      def get_or_default
        return get
      end

      def set(zone)
      end
    end
  end
end
