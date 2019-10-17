# coding: utf-8
# ユーザー
User.create!(name: "Sample User",
             line_id: "12341234",
             email: "test@email.com",
             password: "password",
             password_confirmation: "password",
             address: "神奈川県横浜市戸塚区俣野町1403",
             phone_number: "080-1234-1234",
             admin: 1)
60.times do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@email.com"
  password = "password"
  address = "神奈川県横浜市戸塚区俣野町#{n+1}"
  phone_number = "080-1234-1234#{n+1}"
  User.create!(name: name,
               line_id: "123456789",
               email: email,
               password: password,
               password_confirmation: password,
               address: address,
               phone_number: phone_number)
end

# 商品
Item.create!(item_number: "Fire TV Stick 4K - Alexa対応音声認識リモコン付属",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/416MxeBnCAL._SY300_.jpg",
             part_number: "B079QRQTCR",
             jan_code: "不明",
             simulate_price: 6980)

Item.create!(item_number: "[アルファ インダストリーズ] ボディバッグ 3ポケット 左右肩掛け対応 斜めがけ 200-BAG128 / 200-BAG129",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/7133XWL%2B9DL._UL1280_.jpg",
             part_number: "B079SMLLFQ",
             jan_code: "不明",
             simulate_price: 3980)

# サンプルリサーチ商品
a = 0
b = 0
2.times do
  Research.create!(user_id: 1,
                   japan_image_url: "https://images-na.ssl-images-amazon.com/images/I/7133XWL%2B9DL._UL1280_.jpg",
                   japan_title: "日本の黒カバン#{a += 1}",
                   japan_url: "https://kaban-shop.com/products/detail.php?product_id=14",
                   china_image_url: "https://marimek-prod.store-image.jp/product/52_1_52199247538/52_1_52199247538_main_380x777.jpg?ts=20190914100120",
                   china_title: "中国の黒カバン#{b += 1}",
                   china_url: "https://www.marimekko.jp/shop/marimekko/item/list/category_id/34")
end

#ストックサンプルデータ取込
Stock.create!(
            inventory_arrival_date: 2019-04-24,
            purchase_price:100,
            trader_name:"龍",
            stock:15,
            alert_border_line:3,item_id:2)

# 商品追加
Item.create!(item_number: "携帯タブレットアンドロイド",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/416MxeBnCAL._SY300_.jpg",
             part_number: "B079Q44444",
             jan_code: "不明",
             simulate_price: 15080)

Item.create!(item_number: "アンドロイド搭載一眼レフカメラ",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/7133XWL%2B9DL._UL1280_.jpg",
             part_number: "B079S222",
             jan_code: "不明",
             simulate_price: 18080)

Stock.create!(
            inventory_arrival_date: 2019-07-24,
            purchase_price:120,
            trader_name:"陽商会",
            stock:45,
            alert_border_line:3,item_id:4)
Item.create!(item_number: "MAC / マック シャイニー プリティ シングス グッディ バッグ #ニュートラルアイズ",
             item_picture: "https://item-shopping.c.yimg.jp/i/n/net-pumpkin_0773602505838",
             part_number: "B079S3rt",
             jan_code: "0773602505838",
             simulate_price: 6791)
Stock.create!(
            inventory_arrival_date: 2019-07-24,
            purchase_price:11000,
            trader_name:"北方商会",
            stock:25,
            alert_border_line:3,item_id:4)
Item.create!(item_number: "モペット版 電動機付自転車",
             item_picture: "https://image.rakuten.co.jp/aruzan/cabinet/goods_photo/bike/eb/img57986231.jpg",
             part_number: "B079eert",
             jan_code: "0773602522838",
             simulate_price: 48000,
             yahoo:true,
             amazon:true)
Stock.create!(
            inventory_arrival_date: 2019-05-24,
            purchase_price:46300,
            trader_name:"何法商会",
            stock:28,
            alert_border_line:3,item_id:6)