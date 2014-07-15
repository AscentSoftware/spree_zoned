Spree::Zone.class_eval do
  def currency
    if currency_iso_code.to_s.empty?
      return Spree::Config.original_currency_preference
    end

    return currency_iso_code
  end

  def self.default_currency
    default_zone = default || new()
    return default_zone.currency
  end

  def self.default
    default_zone = find_by(id: SpreeZoned::Config[:default_zone_id])
    return default_zone || first
  end
end
