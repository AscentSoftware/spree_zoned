Spree::Stock::Quantifier.class_eval do
  def initialize(variant)
    @variant = variant
    z = SpreeZoned::ActiveZoneContext.get || Spree::Zone.default
    stock_locations_for_active_zone = SpreeZoned::Stock::ZonedStockLocation.stock_locations_for_zone(z).map(&:id)
    @stock_items = Spree::StockItem.joins(:stock_location).where(variant_id: @variant, stock_location: stock_locations_for_active_zone)
  end
end
