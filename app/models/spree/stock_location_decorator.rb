Spree::StockLocation.class_eval do
  has_many :zoned_stock_locations, class_name: 'SpreeZoned::Stock::ZonedStockLocation'
  has_many :zones, through: :zoned_stock_locations, dependent: :delete_all
end
