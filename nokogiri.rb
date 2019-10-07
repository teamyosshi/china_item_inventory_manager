require 'open-uri'
require 'nokogiri'

# 各ページのURL（例）
url = URI.encode 'https://auctions.yahoo.co.jp/search/search?auccat=&tab_ex=commerce&ei=utf-8&aq=-1&oq=&sc_i=&exflg=1&p=時計&x=24&y=32&fixed=0'


charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを作成
doc = Nokogiri::HTML.parse(html, nil, charset)

# 商品の各ページタイトル
doc.xpath("/html/body[@id='allContents']/div[@class='l-wrapper cf']/div[@class='l-contents']/div[@class='l-contentsBody']/div[@class='Result']/div[@class='Result__body']/div[@class='Products Products--grid']/ul[@class='Products__items']/li[@class='Product']/div[@class='Product__detail']/h3[@class='Product__title']").each do |node|
  puts node
end

# 現在価格
doc.xpath("//div[@class='Product__priceInfo']/span[@class='Product__price']/span[@class='Product__priceValue u-textRed']").each do |node|
  puts node.text
end

# 画像
doc.css("img")[1..2].each do |photo|
  img_box = photo.attribute('src').value
  puts img_box
  break
end


