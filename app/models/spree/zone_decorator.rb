Spree::Zone.class_eval do
  def currency
    return currency_iso_code || Spree::Config.default_currency
  end

  def self.default_currency
    default_zone = default || new()
    return default_zone.currency
  end

  private

    def self.default
      default_zone = find_by(id: SpreeZoned::Config[:default_zone_id])
      return default_zone || first
    end
end
