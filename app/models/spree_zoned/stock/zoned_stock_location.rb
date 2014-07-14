module SpreeZoned
  module Stock
    class ZonedStockLocation < ActiveRecord::Base
      belongs_to :zone, class_name: 'Spree::Zone'
      belongs_to :stock_location, class_name: 'Spree::StockLocation'

      def self.match_by_zone(zone)
        return includes(:stock_location)
          .where(zone: zone, Spree::StockLocation.table_name => {active:true})
          .map(&:stock_location)
      end
    end
  end
end
