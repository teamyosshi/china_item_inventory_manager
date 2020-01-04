class AddItemJapanUrlToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_japan_url, :string
  end
end
