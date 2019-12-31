require 'csv'

find=params[:items_find]
  if find.present?
    @items_find2=Item.search(find)
  else
    @items_find2=Item.all
  end

# bomを作成
bom = %w(EF BB BF).map { |e| e.hex.chr }.join
# generateで引数にbomを渡してあげる
csv_file = CSV.generate(bom) do |csv|
  csv << ["売切れ商品一覧"]
  csv << ["item_picture", "part_number","item_title", "simulate_price", "stocks" ,"yahoo","amazon","mercari","rakuma","rakuten","yahooshopping"]
  @items.each do |b|
    if b.stocks.sum(:stock)==0
      csv << [b.item_picture, b.part_number, b.item_title,b.simulate_price.to_s,b.stocks.sum(:stock).to_s,b.yahoo,b.amazon,b.mercari,b.rakuma,b.rakuten,b.yahooshoping]
    end
  end
end
