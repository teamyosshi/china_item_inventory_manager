class AddBuyItemsTitleAndUrlAndJpyAndCnyToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :buy_item_title, :string
    add_column :stocks, :buy_item_url, :string
    add_column :stocks, :buy_item_to_jpy, :integer
    add_column :stocks, :buy_item_to_cny, :integer
  end
end
