module SpreeZoned
  module ActiveZone
    module ControllerHelper
      extend ActiveSupport::Concern

      included do
        helper_method :active_zone
        helper_method :zone_detected?
      end

      def active_zone
        return SpreeZoned::ActiveZone::Session.current.get_or_default
      end

      def zone_detected?
        return !!SpreeZoned::ActiveZone::Session.current.get
      end
    end
  end
end
