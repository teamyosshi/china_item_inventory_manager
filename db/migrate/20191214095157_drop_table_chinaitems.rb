class DropTableChinaitems < ActiveRecord::Migration[5.2]
  def change
    drop_table :chinaitems
  end
end
