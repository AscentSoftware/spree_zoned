Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    if @request_currency
      return @request_currency
    end

    order = @current_order || Spree::Order.find_by(completed_at: nil, guest_token: cookies.signed[:guest_token])
    @request_currency = get_currency(order)
    return @request_currency
  end

  private

    def get_currency(order)
      is_valid_order = order && order.completed? == false
      if is_valid_order
        return order.currency
      end

      # TODO: This should check if currency is nil and fall through if it is.
      active_zone = SpreeZoned::ActiveZone.get(cookies)
      if active_zone
        return active_zone.currency
      end

      return Spree::Config[:currency]
    end
end
