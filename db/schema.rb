# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_25_213715) do

  create_table "items", force: :cascade do |t|
    t.string "item_number"
    t.string "item_title"
    t.string "item_picture"
    t.string "china_item_picture"
    t.string "part_number"
    t.integer "jan_code"
    t.integer "simulate_price"
    t.boolean "yahoo"
    t.boolean "amazon"
    t.boolean "mercari"
    t.boolean "rakuma"
    t.boolean "rakuten"
    t.boolean "yahooshoping"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "researches", force: :cascade do |t|
    t.string "japan_image_url"
    t.string "japan_title"
    t.string "japan_url"
    t.string "japan_description"
    t.integer "japan_price"
    t.string "china_image_url"
    t.string "china_title"
    t.string "china_url"
    t.integer "china_price"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_researches_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.date "inventory_arrival_date"
    t.integer "purchase_price"
    t.string "trader_name"
    t.integer "stock"
    t.integer "alert_border_line"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_stocks_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "employee_number"
    t.string "line_id"
    t.string "email", null: false
    t.string "address", null: false
    t.string "phone_number"
    t.string "account_bank_name", default: "1", null: false
    t.integer "account_number", default: 1, null: false
    t.integer "business_consignment_expenses", default: 1, null: false
    t.string "password_digest", null: false
    t.boolean "inventory_manager_flg", default: false, null: false
    t.boolean "reserch_user_flg", default: false, null: false
    t.string "fired_flg", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
