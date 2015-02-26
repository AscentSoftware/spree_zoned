module SpreeZoned
  module ActiveCountryControllerHelper
    extend ActiveSupport::Concern

    included do
      helper_method :active_country
    end

    def active_country
      return SpreeZoned::ActiveCountry::Session.current.get
    end
  end
end
