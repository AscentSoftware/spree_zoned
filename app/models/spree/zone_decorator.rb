Spree::Zone.class_eval do
  def currency
    return currency_iso_code || Spree::Config[:currency]
  end
end
