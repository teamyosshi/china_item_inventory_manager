require 'mechanize'
agent = Mechanize.new
page = agent.get("https://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=watch")
doc = page.search('//script')

# 空白にカンマを入れ、特定の取り出しやすい文字列に修正し、カンマ区切りで分割、一意性ありにしてダブりを消して配列にした。
hoge = doc.text.gsub(" ",",").gsub('multiImg":[','"multiImg://').gsub('//s.alicdn.com/','https://s.alicdn.com/').split(',').uniq.to_a

# 配列を作るための準備
@item_no ||= 0
# アイテムナンバーの配列を作る準備
# @item_number_list = [@item_no]
hash = Hash.new { |h,k| h[k] = {} }

#tabとかnとかの余計な文字列がはいってしまうので、削除してから特定の文字列が入っているものだけをitems配列にくわえた。
hoge.each do |xxx|
  if xxx.include?('https://s.alicdn.com/@sc01/')
    @item_no += 1
    # @item_number_list.push("#{@item_no}")
    if xxx[0] == "\""
      xxx.slice!(0)
      xxx.slice!(-1)
      xxx.gsub("ttps://","https://")
    end
    if xxx[0] == "'"
      xxx.slice!(0)
      xxx.slice!(-3)
      xxx.slice!(-2)
      xxx.slice!(-1)
    end
    if hash["#{@item_no - 1}"]["china_image_url"].present? && hash["#{@item_no - 1}"]["china_image_url"][-30..-1] == xxx[-30..-1]
      puts "#{@item_no}は前回と画像イメージが同じなのでスキップ"
      @item_no -= 1
      next
    end
    puts "#{@item_no}を正常に処理します。"
    hash["#{@item_no}"]["china_image_url"] = xxx
  end
end