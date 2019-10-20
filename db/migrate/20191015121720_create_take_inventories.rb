class CreateTakeInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :take_inventories do |t|
      t.integer :fiscal_year
      t.integer :beginning_product_inventory
      t.integer :cost_of_sales
      t.string :period_end_product_inventory

      t.timestamps
    end
  end
end
