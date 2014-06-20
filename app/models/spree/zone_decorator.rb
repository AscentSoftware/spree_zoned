Spree::Zone.class_eval do
  def currency
    return currency_iso_code || Spree::Config[:currency]
  end

  private

    def self.default
      default_zone = find_by(id: SpreeZoned::Config[:default_zone_id])
      return default_zone || first
    end
end
