# coding: utf-8
# ユーザー
User.create!(name: "Sample User",
             line_id: "12341234",
             email: "test@email.com",
             password: "password",
             password_confirmation: "password",
             address: "神奈川県横浜市戸塚区俣野町1403",
             phone_number: "080-1234-1234",
             inventory_manager_flg: true,
             reserch_user_flg: true,
             admin: 1)

10.times do |n|
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
               phone_number: phone_number,
               inventory_manager_flg: true
  )
end

# 商品
Item.create!(item_title: "Fire TV Stick 4K - Alexa対応音声認識リモコン付属",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/416MxeBnCAL._SY300_.jpg",
             part_number: "B079QRQTCR",
             jan_code: "不明",
             simulate_price: 6980)

Item.create!(item_title: "[アルファ インダストリーズ] ボディバッグ 3ポケット 左右肩掛け対応 斜めがけ 200-BAG128 / 200-BAG129",
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

Buyitem.create!(
    japan_image_url:"https://img.alicdn.com/imgextra/i4/850320452/O1CN01glcs1m1FD3agMdVMw_!!850320452.jpg",
    japan_title:"純正 YAMAHA ヤマハ f310 バラードウッドギター",
    japan_url:"https://chinamart.jp/tmall_item?iid=20525092687&key=15dfecc5d9b49932afe67bdc012b3dd5&sellerid=850320452",
    japan_description:"純正 YAMAHA ヤマハ f310 バラードウッドギター初心者入門学生男性と女性の電気ボックス",
    japan_price:17719,
    china_image_url:"http://img.alicdn.com/bao/uploaded/i1/850320452/O1CN01JtIz7S1FD3akD8Q9K_!!0-item_pic.jpg_160x160.jpg",
    china_title:"正品YAMAHA雅马哈f310民谣木吉他初学者入门学生男女电箱41寸f600",
    china_url:"https://chinamart.jp/tmall_item?iid=20525092687&key=15dfecc5d9b49932afe67bdc012b3dd5&sellerid=850320452",
    china_price:899,
    user_id:1)
Buyitem.create!(
    japan_image_url:"https://cbu01.alicdn.com/img/ibank/2018/725/696/9323696527_1359731289.460x460xz.jpg",
    japan_title:"全自動壁ブレーカー",
    japan_url:"https://chinamart.jp/alibaba_item?iid=551312382726&key=9e0b982b3aa924fd0beeff2442f07093",
    japan_description:"全自動壁ブレーカー加熱攪拌多機能搾り搾り肉ベビー補助食品豆乳機代用 OEM",
    japan_price:11822,
    china_image_url:"https://cbu01.alicdn.com/img/ibank/2018/725/696/9323696527_1359731289.460x460xz.jpg",
    china_title:"全自动破壁机加热搅拌多功能榨汁绞肉婴儿辅食料理豆浆机代发OEM",
    china_url:"https://chinamart.jp/alibaba_item?iid=551312382726&key=9e0b982b3aa924fd0beeff2442f07093",
    china_price:591,
    user_id:1)
Buyitem.create!(
    japan_image_url:"https://cbu01.alicdn.com/img/ibank/2019/465/787/11637787564_1988683686.460x460xz.jpg",
    japan_title:"新しいまつげクリップ",
    japan_url:"https://chinamart.jp/alibaba_item?iid=598197591869&key=e1af8d68c77b7adcb47023216b078263",
    japan_description:"新しいまつげクリップ ロールマスカラチャージ美容ツール電気ホットクロスボーダーまつげクリップ メーカーダイレクトマーケティング",
    japan_price:1561,
    china_image_url:"https://cbu01.alicdn.com/img/ibank/2019/465/787/11637787564_1988683686.460x460xz.jpg",
    china_title:"新款睫毛夹 卷翘睫毛器充电美妆工具电动烫跨境睫毛夹 厂家直销",
    china_url:"https://chinamart.jp/alibaba_item?iid=598197591869&key=e1af8d68c77b7adcb47023216b078263",
    china_price:78,
    user_id:1)
