class CreateJoinTableZonedStockLocations < ActiveRecord::Migration
  def change
    create_join_table :stock_locations, :zones, table_name: 'spree_zoned_zoned_stock_locations' do |t|
      t.index [:stock_location_id, :zone_id], unique: true, name: 'index_uniq_stock_location_id_by_zone_id'
    end
  end
end
