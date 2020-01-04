class AddOriginalStockToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :original_stock, :integer
  end
end
