Spree::BaseController.class_eval do
  include SpreeZoned::ActiveZone::ControllerHelper
  include SpreeZoned::ActiveCountryControllerHelper
end
