Spree::Zone.class_eval do
  def currency
    if name == "North America"
      return "USD"
    end

    return Spree::Config[:currency]
  end
end
