class AddCurrencyIsoCodeToSpreeZones < ActiveRecord::Migration
  def change
    add_column :spree_zones, :currency_iso_code, :string, default: nil, null: true, limit: 10
  end
end
