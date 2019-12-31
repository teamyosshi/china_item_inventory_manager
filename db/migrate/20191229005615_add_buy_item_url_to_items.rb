class AddBuyItemUrlToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :buy_item_url, :string
  end
end
