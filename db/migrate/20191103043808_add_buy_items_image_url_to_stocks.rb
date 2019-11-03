class AddBuyItemsImageUrlToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :buy_item_image_url, :string
  end
end
