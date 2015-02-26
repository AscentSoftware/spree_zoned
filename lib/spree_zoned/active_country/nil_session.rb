module SpreeZoned
  module ActiveCountry
    class NilSession
      def get
        return nil
      end

      def set(zone)
      end
    end
  end
end
