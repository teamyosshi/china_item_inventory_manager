require 'kconv'
require "stocks_helper"

result = ''
result << "商品画像"+","+"製品コード"+","+"商品タイトル"+","+"在庫計"+","+"限定価格"+","+"出品サイト"
result << "\r"
@items_find2.each do |b|
  yahoo=b.yahoo
	amazon=b.amazon
	mercari=b.mercari
	rakuma=b.rakuma
	rakuten=b.rakuten
	yahooshoping=b.yahooshoping
  ex=exhibition(yahoo,amazon,mercari,rakuma,rakuten,yahooshoping)
  result << b.item_picture+","+ b.part_number+","+ b.item_number+","+b.stocks.sum(:stock).to_s+","+b.simulate_price.to_s+","+ex
  result << "\r"
end
result.kconv(Kconv::SJIS, Kconv::UTF8)
