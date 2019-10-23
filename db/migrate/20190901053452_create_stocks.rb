class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.date :inventory_arrival_date
      t.integer :purchase_price
      t.string :trager_name
      t.integer :stock
      t.integer :original_stock
      t.integer :alert_border_line
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
