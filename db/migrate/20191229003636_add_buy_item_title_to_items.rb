class AddBuyItemTitleToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :buy_item_title, :string
  end
end
