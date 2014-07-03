Spree::BaseController.class_eval do
  include SpreeZoned::ActiveZoneControllerHelper
  include SpreeZoned::ActiveCountryControllerHelper
end
