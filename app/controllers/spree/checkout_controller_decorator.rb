Spree::CheckoutController.class_eval do
  alias_method :update_orig, :update

  def update
    update_orig

    SpreeZoned::ActiveZone.set(cookies, @order.shipping_zone)
  end
end
