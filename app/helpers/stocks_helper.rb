module StocksHelper

  def calculation_item_cost
    @item_stocks.each do |item_stock|
      #今年度仕入原価合計を計算
      cost_of_salse = item_stock.purchase_price.to_i * item_stock.original_stock.to_i
      @total_purchase_cost_this_year = @total_purchase_cost_this_year.to_i + cost_of_salse
      #今年度期末商品棚卸高の計算
      cost_salse = item_stock.purchase_price * item_stock.stock
      @period_end_product_inventory = @period_end_product_inventory.to_i + cost_salse
    end
  end
  def calculation_of_total_amount
    if @this_year_beginning_product_inventory.beginning_product_inventory.present? && @total_purchase_cost_this_year.present? && @period_end_product_inventory.present?
      @total_cost_of_sales = @this_year_beginning_product_inventory.beginning_product_inventory + @total_purchase_cost_this_year - @period_end_product_inventory
    end
    @this_year_beginning_product_inventory.update_attributes(cost_of_sales: @total_cost_of_sales, period_end_product_inventory: @period_end_product_inventory)
  end
end
