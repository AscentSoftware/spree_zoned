Spree::Admin::GeneralSettingsHelper.module_eval do
  def zone_options
    zones = Spree::Zone.all.map do |zone|
      [zone.id, "#{zone.name} (#{zone.description})"]
    end
    options_from_collection_for_select(zones, :first, :last, SpreeZoned::Config[:default_zone_id])
  end

  def currency_options
    currencies = ::Money::Currency.table.map do |code, details|
      iso = details[:iso_code]
      [iso, "#{details[:name]} (#{iso})"]
    end
    options_from_collection_for_select(currencies, :first, :last, Spree::Config.original_currency_preference)
  end
end
