module SpreeZoned
  module ActiveZoneControllerHelper
    extend ActiveSupport::Concern

    included do
      helper_method :active_zone
    end

    def active_zone
      return SpreeZoned::ActiveZone.get(cookies) || Spree::Zone.default
    end
  end
end
