class AddSimulatePriceToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :simulate_price, :integer
  end
end
