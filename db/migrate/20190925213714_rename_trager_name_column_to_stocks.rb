class RenameTragerNameColumnToStocks < ActiveRecord::Migration[5.2]
  def change
    rename_column :stocks, :trager_name, :trader_name
  end
end
