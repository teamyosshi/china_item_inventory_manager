# coding: utf-8

# ユーザー
User.create!(name: "Sample User",
             line_id: "12341234",
             email: "sample@email.com",
             password: "sample",
             admin: 1,
             address:"千葉県",
             account_bank_name:"22",
             account_number:222,
             business_consignment_expenses:3333,
             inventory_manager_flg:false,
             fired_flg:"test",
             reserch_user_flg:false)
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

# 外部制約キー（FK：user_id, item_id）を含んでcreate!
# サンプルリサーチ商品
a = 0
60.times do
  Research.create!(user_id: 1,
                   item_id: 1,
                   japan_image_url: "https://images-na.ssl-images-amazon.com/images/I/7133XWL%2B9DL._UL1280_.jpg",
                   japan_title: "日本の黒カバン#{a += 1}",
                   japan_url: "https://kaban-shop.com/products/detail.php?product_id=14",
                   china_image_url: "https://marimek-prod.store-image.jp/product/52_1_52199247538/52_1_52199247538_main_380x777.jpg?ts=20190914100120",
                   china_title: "中国の黒カバン#{a += 1}",
                   china_url: "https://www.marimekko.jp/shop/marimekko/item/list/category_id/34")
end

Stock.create!(inventory_arrival_date: 2019-04-24,
                purchase_price:100,
                trader_name:"龍",
                stock:15,
                alert_border_line:3,item_id:3)
