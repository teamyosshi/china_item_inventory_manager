require 'csv'

CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = %w(仕入れ日 タイトル JANコード 業者名 金額 購入数)
  csv << csv_column_names
  @item_stocks.each do |item_stock|
    column_values = [
      item_stock.inventory_arrival_date,
      item_stock.item.item_title,
      item_stock.item.jan_code,
      item_stock.trader_name,
      item_stock.purchase_price,
      item_stock.stock
    ]
    csv << column_values
  end
  csv_column_names = %w(前年度期末商品棚卸高 今年度仕入原価合計額 今年度期末商品棚卸高 売上原価)
  csv << csv_column_names
  column_values = [
    unless @this_year_beginning_product_inventory.beginning_product_inventory.nil?
      @this_year_beginning_product_inventory.beginning_product_inventory
    end,
    @total_purchase_cost_this_year,
    if @this_year_beginning_product_inventory.period_end_product_inventory.present?
      @this_year_beginning_product_inventory.period_end_product_inventory
    end,
    if @this_year_beginning_product_inventory.cost_of_sales.present?
      @this_year_beginning_product_inventory.cost_of_sales
    end
  ]
  csv << column_values
end