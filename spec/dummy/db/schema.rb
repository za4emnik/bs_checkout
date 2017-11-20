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

ActiveRecord::Schema.define(version: 20171114163033) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "bs_checkout_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "zip"
    t.integer  "country_id"
    t.string   "phone"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "type"
    t.boolean  "use_billing_address", default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["addressable_type", "addressable_id"], name: "addressable_type"
    t.index ["country_id"], name: "index_bs_checkout_addresses_on_country_id"
  end

  create_table "bs_checkout_countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bs_checkout_coupons", force: :cascade do |t|
    t.string   "code"
    t.decimal  "value",      precision: 8, scale: 2
    t.integer  "order_id"
    t.boolean  "active",                             default: true
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["order_id"], name: "index_bs_checkout_coupons_on_order_id"
  end

  create_table "bs_checkout_credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "date"
    t.integer  "cvv"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_bs_checkout_credit_cards_on_order_id"
  end

  create_table "bs_checkout_deliveries", force: :cascade do |t|
    t.string   "name"
    t.string   "interval"
    t.decimal  "price",      precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "bs_checkout_order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_bs_checkout_order_items_on_order_id"
  end

  create_table "bs_checkout_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "delivery_id"
    t.decimal  "total",       precision: 8, scale: 2, default: "0.0"
    t.decimal  "subtotal",    precision: 8, scale: 2, default: "0.0"
    t.string   "aasm_state"
    t.string   "number",                              default: "R00000000"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.index ["delivery_id"], name: "index_bs_checkout_orders_on_delivery_id"
    t.index ["user_id"], name: "index_bs_checkout_orders_on_user_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
