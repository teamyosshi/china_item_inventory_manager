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
               phone_number: phone_number)
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


#ストックサンプルデータ取込
Stock.create!(
            inventory_arrival_date: '2019-04-24',
            purchase_price:3500,
            trader_name:"龍",
            stock:15,
            original_stock: 100,
            alert_border_line:3,item_id:2)

# 商品追加
Item.create!(item_title: "携帯タブレットア��ドロイド",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/416MxeBnCAL._SY300_.jpg",
             part_number: "B079Q44444",
             jan_code: "不明",
             simulate_price: 15080)

Item.create!(item_title: "アンドロイド搭載一眼レフカメラ",
             item_picture: "https://images-na.ssl-images-amazon.com/images/I/7133XWL%2B9DL._UL1280_.jpg",
             part_number: "B079S222",
             jan_code: "不明",
             simulate_price: 18080)

Stock.create!(
            inventory_arrival_date: '2019-07-24',
            purchase_price:120,
            trader_name:"陽商会",
            stock:45,
            original_stock: 100,
            alert_border_line:3,item_id:4)
Item.create!(item_title: "MAC / マック シャイニー プリティ シングス グッディ バッグ #ニュートラルアイズ",
             item_picture: "https://item-shopping.c.yimg.jp/i/n/net-pumpkin_0773602505838",
             part_number: "B079S3rt",
             jan_code: "0773602505838",
             simulate_price: 6791)
Stock.create!(
            inventory_arrival_date: '2019-07-24',
            purchase_price:11000,
            trader_name:"北方商会",
            original_stock: 100,
            stock:25,
            alert_border_line:3,item_id:4)
Item.create!(item_title: "モペット版 電動機付自転車",
             item_picture: "https://image.rakuten.co.jp/aruzan/cabinet/goods_photo/bike/eb/img57986231.jpg",
             part_number: "B079eert",
             jan_code: "0773602522838",
             simulate_price: 48000,
             yahoo:true,
             amazon:true)
Item.create!(item_title: "ヘンユアンシアンウール",
             item_picture: "http://img02.taobaocdn.com/bao/uploaded/i3/908948999/O1CN01cn3B5R2GLalsS1Cmg_!!0-item_pic.jpg",
             part_number: "560545085804",
             jan_code: "不明",
             simulate_price:5304 )

Item.create!(item_title: "カスタム野球帽刺繍ロゴオーダー帽子",
             item_picture: "http://img02.taobaocdn.com/bao/uploaded/i4/4132611238/O1CN01HOAYva1L12trLchSs_!!0-item_pic.jpg",
             part_number: "586544174650",
             jan_code: "不明",
             simulate_price:392 )
#ストックサンプルデータ取込
Stock.create!(
            inventory_arrival_date: '2019-04-24',
            purchase_price:3500,
            trader_name:"龍",
            stock:10,
            alert_border_line:3,item_id:2)
Stock.create!(
            inventory_arrival_date: '2019-05-24',
            purchase_price:46300,
            trader_name:"何法商会",
            stock:28,
            alert_border_line:3,item_id:6)
Stock.create!(
            inventory_arrival_date: '2019-07-24',
            purchase_price:11000,
            trader_name:"北方商会",
            stock:25,
            original_stock:100,
            alert_border_line:3,item_id:6)

10.times do |n|
  item_title = "携帯タブレットアンドロイド#{n+1}"
  item_picture = "https://images-na.ssl-images-amazon.com/images/I/416MxeBnCAL._SY300_.jpg"
  part_number = "B079S3rt#{n+1}"
  jan_code = "0773602505838#{n+1}"
  simulate_price = "48000#{n+1}"
    Item.create!(item_title: item_title,
      item_picture: item_picture,
      part_number: part_number,
      jan_code: jan_code,
      simulate_price: simulate_price,)
  end
100.times do |d|
  Stock.create!(
    inventory_arrival_date: '2019-05-24',
    purchase_price:46300,
    trader_name:"何法商会",
    stock:28,
    original_stock: 100,
    alert_border_line:3,item_id:6)
end
TakeInventory.create!(
  fiscal_year:2017,
  beginning_product_inventory:2018,
  cost_of_sales:2018,
  period_end_product_inventory:2018)
TakeInventory.create!(
  fiscal_year:2016,
  beginning_product_inventory:2018,
  cost_of_sales:2018,
  period_end_product_inventory:2018)
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
Research.create!(
  japan_image_url:"https://wing-auctions.c.yimg.jp/sim?furl=auctions.c.yimg.jp/images.auctions.yahoo.co.jp/image/dr000/auc0511/users/c735a94bb47f29584b1c197dfc26f9a9ec0d9725/i-img900x1200-157424669063ltkc124475.jpg&dc=1&sr.fs=20000",
  japan_title:"PAGANI DESIGN 腕時計クロノグラフ CX-2332-WH",
  japan_url:"https://page.auctions.yahoo.co.jp/jp/auction/w351371235",
  japan_price:"1",
  user_id:1)
Research.create!(
  china_image_url:"https://cbu01.alicdn.com/img/ibank/2019/465/787/11637787564_1988683686.460x460xz.jpg",
  china_title:"新款睫毛夹 卷翘睫毛器充电美妆工具电动烫跨境睫毛夹 厂家直销",
  china_url:"https://chinamart.jp/alibaba_item?iid=598197591869&key=e1af8d68c77b7adcb47023216b078263",
  china_price:78,
  user_id:1)
