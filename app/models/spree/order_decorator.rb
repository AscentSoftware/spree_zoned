Spree::Order.class_eval do
  alias_method :create_tax_charge_orig!, :create_tax_charge!
  alias_method :update_line_item_currencies_orig!, :update_line_item_currencies!

  # Override to hook into the checkout update process.
  # Change the currency of the order when the shipping address changes.
  def create_tax_charge!
    ensure_currency_matches_zone
    create_tax_charge_orig!
  end

  def ensure_currency_matches_zone
    if state == 'address' && self[:currency] != shipping_zone.currency
      adjustments.destroy_all
      shipments.destroy_all

      self[:currency] = shipping_zone.currency
      save!
    end
  end

  def shipping_zone
    return Spree::Zone.match(ship_address)
  end

  # This method comes from the Spree::Order::CurrencyUpdater module.
  # This version forces a reload of the line items so that the new
  # prices are used when recalculating the order totals.
  def update_line_item_currencies!
    update_line_item_currencies_orig!
    line_items.reload
  end
end
