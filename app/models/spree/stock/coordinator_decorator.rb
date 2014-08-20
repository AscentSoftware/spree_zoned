Spree::Stock::Coordinator.class_eval do
  def build_packages(packages = Array.new)
    stock_locations_for(order).each do |stock_location|
      next unless stock_location.stock_items.where(:variant_id => inventory_units.map(&:variant_id)).exists?

      packer = build_packer(stock_location, inventory_units)
      packages += packer.packages
    end
    packages
  end

  def stock_locations_for(order)
    SpreeZoned::Stock::StockLocationPicker.new.for_order(order)
  end
end
