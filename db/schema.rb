# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_02_131807) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.string "image"
    t.string "contract_id"
  end

  create_table "histories", force: :cascade do |t|
    t.float "price"
    t.datetime "date_time"
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_histories_on_collection_id"
  end

  create_table "nfts", force: :cascade do |t|
    t.string "name"
    t.date "purchase_date"
    t.float "purchase_price"
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["collection_id"], name: "index_nfts_on_collection_id"
  end

  create_table "portfolio_collections", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_portfolio_collections_on_collection_id"
    t.index ["portfolio_id"], name: "index_portfolio_collections_on_portfolio_id"
  end

  create_table "portfolio_nfts", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "nft_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nft_id"], name: "index_portfolio_nfts_on_nft_id"
    t.index ["portfolio_id"], name: "index_portfolio_nfts_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "histories", "collections"
  add_foreign_key "nfts", "collections"
  add_foreign_key "portfolio_collections", "collections"
  add_foreign_key "portfolio_collections", "portfolios"
  add_foreign_key "portfolio_nfts", "nfts"
  add_foreign_key "portfolio_nfts", "portfolios"
  add_foreign_key "portfolios", "users"
end
