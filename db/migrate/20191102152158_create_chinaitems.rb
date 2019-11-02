class CreateChinaitems < ActiveRecord::Migration[5.2]
  def change
    create_table :chinaitems do |t|
      t.string :image_url
      t.string :title
      t.string :url
      t.integer :price

      t.timestamps
    end
  end
end
