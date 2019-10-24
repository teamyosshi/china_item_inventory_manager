require 'selenium-webdriver'
require 'webdrivers'

driver = Selenium::WebDriver.for :chrome #使用するブラウザを選択
driver.navigate.to "https://shop9285ox4k52841.1688.com/page/offerlist.htm?suggestiontype=winport&spm=a2615.2177701.20151125147.d147&keywords=%D1%A7%C9%FA%B0%FC&sug=1_0" #URL指定

# 要素出力
doc = driver.find_elements(:xpath,"//ul[@class='offer-list-row']")
doc.each do |i|
  puts i.text
end

# タイトル　単体・・・エラー
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer'][1]/div[@class='title-new']/a[@class='title-link']")
puts doc.text

doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer'][1]/div[@class='title-new']/a[@class='title-link']").attribute("title-link")
puts doc


# タイトル　each文
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer']/div[@class='title-new']/a[@class='title-link']")
doc.each do |i|
  puts i.text
end

# 金額・・・エラー
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer'][1]/div[@class='fd-clr price-main']/div[@class='price price-new']/em[@class='price-container']")
puts doc.text

# 金額　each文
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer']/div[@class='fd-clr price-main']/div[@class='price price-new']/em[@class='price-container']")
doc.each do |i|
  puts i.text
end

# 画像・・・エラー
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer'][1]/div[@class='image']/a/img/@src")
puts doc.text

# 画像　each文・・・エラー
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer']/div[@class='image']/a/img/@src")
doc.each do |i|
  puts i.text
end

# URL・・・エラー
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer'][1]/div[@class='title-new']/a[@class='title-link']/@href")
puts doc.text

# URL　each文・・・エラー
doc = driver.find_elements(:xpath,"//li[@class='offer-list-row-offer']/div[@class='title-new']/a[@class='title-link']/@href")
doc.each do |i|
  puts i.text
end

driver.quit #ブラウザを閉じて終了

# 画面表示なし
# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
#
# driver = Selenium::WebDriver.for :chrome, options: options #使用するブラウザを選択
# driver.navigate.to "https://shop9285ox4k52841.1688.com/page/offerlist.htm?suggestiontype=winport&spm=a2615.2177701.20151125147.d147&keywords=%D1%A7%C9%FA%B0%FC&sug=1_0" #URL指定
