Spree::CheckoutController.class_eval do
  alias_method :update_orig, :update

  def update
    update_orig

    SpreeZoned::ActiveZone::Session.current.set(@order.shipping_zone)
    shipping_country = @order.ship_address && @order.ship_address.country
    SpreeZoned::ActiveCountry.set(cookies, shipping_country)
  end
end
