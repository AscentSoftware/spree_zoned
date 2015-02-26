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

  # Override to set the active country for the default address
  private def before_address
    # if the user has a default address, a callback takes care of setting
    # that; but if he doesn't, we need to build an empty one here

    @order.bill_address ||= build_default_address
    @order.ship_address ||= build_default_address if @order.checkout_steps.include?('delivery')
  end

  # Returns an address with the country set to either; the active country;
  # the first country for the active zone; or the default country.
  private def build_default_address
    country = SpreeZoned::ActiveCountry::Session.current.get
    if country == nil
      zone = SpreeZoned::ActiveZone::Session.current.get
      country = (zone && zone.country_list.first) || Spree::Country.default
    end

    return Spree::Address.new(country: country)
  end
end
