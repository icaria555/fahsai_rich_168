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

ActiveRecord::Schema.define(version: 20161124092924) do

  create_table "amphurs", force: :cascade do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name", "province_id"], name: "index_amphurs_on_name_and_province_id", unique: true
    t.index ["name"], name: "index_amphurs_on_name"
    t.index ["province_id"], name: "index_amphurs_on_province_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "product_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_discounts_on_product_id"
    t.index ["role_id"], name: "index_discounts_on_role_id"
  end

  create_table "district_zipcodes", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "zipcode_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["district_id", "zipcode_id"], name: "index_district_zipcodes_on_district_id_and_zipcode_id", unique: true
    t.index ["district_id"], name: "index_district_zipcodes_on_district_id"
    t.index ["zipcode_id"], name: "index_district_zipcodes_on_zipcode_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "amphur_id"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amphur_id"], name: "index_districts_on_amphur_id"
    t.index ["name", "amphur_id"], name: "index_districts_on_name_and_amphur_id", unique: true
    t.index ["name"], name: "index_districts_on_name"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.float    "total_price"
    t.float    "total_pv"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "purchaser_id"
    t.integer  "saler_id"
    t.float    "total_price"
    t.float    "total_pv"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "product_statements", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "statement_id"
    t.integer  "quantity"
    t.float    "total_price"
    t.float    "total_pv"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["product_id"], name: "index_product_statements_on_product_id"
    t.index ["statement_id"], name: "index_product_statements_on_statement_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.float    "pv"
    t.integer  "quantity"
    t.string   "unit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_provinces_on_name", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.integer  "giver_id"
    t.integer  "receiver_id"
    t.float    "total_price"
    t.float    "total_pv"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stocks_on_product_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "member_code"
    t.string   "iden_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.integer  "district_id"
    t.integer  "amphur_id"
    t.integer  "province_id"
    t.integer  "zipcode_id"
    t.string   "phone_number"
    t.string   "line_id"
    t.integer  "role_id"
    t.date     "birthday"
    t.string   "gender"
    t.index ["amphur_id"], name: "index_users_on_amphur_id"
    t.index ["district_id"], name: "index_users_on_district_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["iden_number"], name: "index_users_on_iden_number", unique: true
    t.index ["member_code"], name: "index_users_on_member_code", unique: true
    t.index ["province_id"], name: "index_users_on_province_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["zipcode_id"], name: "index_users_on_zipcode_id"
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_zipcodes_on_code", unique: true
  end

end
