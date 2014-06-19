Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    if @request_currency
      return @request_currency
    end

    order = @current_order || Spree::Order.find_by(completed_at: nil, guest_token: cookies.signed[:guest_token])

    if order.nil? || order.completed?
      @request_currency = Spree::Config[:currency]
    else
      @request_currency = order.currency
    end

    return @request_currency
  end
end
