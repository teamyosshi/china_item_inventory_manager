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
Research.create!(user_id: 1, item_id: 1)

# サンプルリサーチ商品
a = 0
60.times do
  Research.create!(user_id: 1,
                   item_id: 1,
                   japan_image_url: "https://images-na.ssl-images-amazon.com/images/I/7133XWL%2B9DL._UL1280_.jpg",
                   japan_title: "黒カバン#{a += 1}",
                   japan_url: "https://kaban-shop.com/products/detail.php?product_id=14")
end


Stock.create!(inventory_arrival_date: 2019-04-24,
            purchase_price:100,
            trader_name:"龍",
            stock:15,
            alert_border_line:3,item_id:3)
