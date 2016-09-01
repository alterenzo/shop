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

ActiveRecord::Schema.define(version: 20160901064237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applied_vouchers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cart_id"
    t.integer  "voucher_id"
    t.index ["cart_id"], name: "index_applied_vouchers_on_cart_id", using: :btree
    t.index ["voucher_id"], name: "index_applied_vouchers_on_voucher_id", using: :btree
  end

  create_table "cart_elements", force: :cascade do |t|
    t.integer  "quantity",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "product_id"
    t.integer  "cart_id"
    t.index ["cart_id"], name: "index_cart_elements_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_cart_elements_on_product_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_vouchers", id: false, force: :cascade do |t|
    t.integer "voucher_id",  null: false
    t.integer "category_id", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "category_id"
    t.integer  "stock",           default: 1
    t.decimal  "discount_amount", default: "0.0"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
  end

  create_table "vouchers", force: :cascade do |t|
    t.string   "code"
    t.decimal  "discount_amount"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.decimal  "min_amount",      default: "0.0"
    t.integer  "category_id"
    t.index ["category_id"], name: "index_vouchers_on_category_id", using: :btree
  end

  add_foreign_key "applied_vouchers", "carts"
  add_foreign_key "applied_vouchers", "vouchers"
  add_foreign_key "cart_elements", "carts"
  add_foreign_key "cart_elements", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "vouchers", "categories"
end
