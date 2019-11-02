class CreateBuyitems < ActiveRecord::Migration[5.2]
  def change
    create_table :buyitems do |t|
      t.string :japan_image_url
      t.string :japan_title
      t.string :japan_url
      t.string :japan_description
      t.integer :japan_price
      t.string :china_image_url
      t.string :china_title
      t.string :china_url
      t.integer :china_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
