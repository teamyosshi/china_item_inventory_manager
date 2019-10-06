class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_number
      t.string :item_title
      t.string :item_picture
      t.string :china_item_picture
      t.string :part_number
      t.integer :jan_code
      t.integer :simulate_price
      t.boolean :yahoo
      t.boolean :amazon
      t.boolean :mercari
      t.boolean :rakuma
      t.boolean :rakuten
      t.boolean :yahooshoping

      t.timestamps
    end
  end
end
