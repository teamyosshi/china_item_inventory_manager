class CreateJapanitems < ActiveRecord::Migration[5.2]
  def change
    create_table :japanitems do |t|
      t.string :image_url
      t.string :title
      t.string :url
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
