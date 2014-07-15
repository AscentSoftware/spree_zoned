module SpreeZoned
  module Stock
    class StockLocationPicker
      def for_order(order)
        order_zone = order.shipping_zone
        return SpreeZoned::Stock::ZonedStockLocation.stock_locations_for_zone(order_zone)
      end
    end
  end
end
