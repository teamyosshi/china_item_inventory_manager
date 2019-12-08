class CreateResearches < ActiveRecord::Migration[5.2]
  def change
    create_table :researches do |t|
      t.string :japan_image_url
      t.string :japan_title
      t.string :japan_url
      t.string :japan_description
      t.integer :japan_price
      t.string :china_image_url
      t.string :china_title
      t.string :china_url
      t.float :china_price
      t.float :simulate_price
      t.integer :jpn_reseach_check
      t.integer :chn_reseach_check
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
