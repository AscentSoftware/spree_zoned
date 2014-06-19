Spree::Order.class_eval do
  alias_method :update_line_item_currencies_orig!, :update_line_item_currencies!

  # This method comes from the Spree::Order::CurrencyUpdater module.
  # This version forces a reload of the line items so that the new
  # prices are used when recalculating the order totals.
  def update_line_item_currencies!
    update_line_item_currencies_orig!
    line_items.reload
  end
end
