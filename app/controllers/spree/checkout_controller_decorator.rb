Spree::CheckoutController.class_eval do
  alias_method :update_orig, :update

  # Override to change the active zone to match the address just entered by the
  # customer.
  def update
    update_orig

    SpreeZoned::ActiveZone::Session.current.set(@order.shipping_zone)
    shipping_country = @order.ship_address && @order.ship_address.country
    SpreeZoned::ActiveCountry::Session.current.set(shipping_country)
  end
end
