class AddItemNumberAndPartNumberToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :item_number, :string
    add_column :stocks, :part_number, :string
  end
end
