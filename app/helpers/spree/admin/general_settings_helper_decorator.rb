Spree::Admin::GeneralSettingsHelper.module_eval do
  def zone_options
    zones = Spree::Zone.all.map do |zone|
      [zone.id, "#{zone.name} (#{zone.description})"]
    end
    options_from_collection_for_select(zones, :first, :last, SpreeZoned::Config[:default_zone_id])
  end
end
