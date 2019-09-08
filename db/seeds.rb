# coding: utf-8

User.create!(name: "Sample User",
             line_id: "12341234",
             email: "sample@email.com",
             password: "sample",
             admin: 1)
Item.create!(item_number: "商品A",
             item_image: "ここにURLがはいります",
             part_number: 1,
             jan_code: 1,
             simulate_price: 100)