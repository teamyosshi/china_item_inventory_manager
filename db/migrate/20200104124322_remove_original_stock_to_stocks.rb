class RemoveOriginalStockToStocks < ActiveRecord::Migration[5.2]
  def up
    remove_column :stocks, :original_stock, :integer 
    remove_column :stocks, :item_number, :string
    remove_column :stocks, :part_number, :string
    remove_column :stocks, :buy_item_title, :string
    remove_column :stocks, :buy_item_image_url, :string
  end
end
