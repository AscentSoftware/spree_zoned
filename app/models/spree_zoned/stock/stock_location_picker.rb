module SpreeZoned
  module Stock
    class StockLocationPicker
      def for_order(order)
        order_zone = order.shipping_zone
        return SpreeZoned::Stock::ZonedStockLocation.match_by_zone(order_zone)
      end
    end
  end
end
