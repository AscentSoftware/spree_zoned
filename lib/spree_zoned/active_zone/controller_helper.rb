module SpreeZoned
  module ActiveZone
    module ControllerHelper
      extend ActiveSupport::Concern

      included do
        helper_method :active_zone
      end

      def active_zone
        return SpreeZoned::ActiveZone::Session.current.get_or_default
      end
    end
  end
end
