require 'csv'
# bomを作成
bom = %w(EF BB BF).map { |e| e.hex.chr }.join
# generateで引数にbomを渡してあげる
csv_file = CSV.generate(bom) do |csv|
  csv << ["僅少商品一覧"]
  csv << ["商品画像", "製品コード", "商品タイトル","在庫計","限定価格","出品サイト"]
  @items.each do |b|
    if b.stocks.sum(:stock)<25
      yahoo=b.yahoo
	    amazon=b.amazon
	    mercari=b.mercari
	    rakuma=b.rakuma
	    rakuten=b.rakuten
	    yahooshoping=b.yahooshoping
      ex=exhibition(yahoo,amazon,mercari,rakuma,rakuten,yahooshoping)
      csv << [b.item_picture, b.part_number, b.item_title,b.stocks.sum(:stock).to_s,b.simulate_price.to_s,ex]
    end
  end
end
