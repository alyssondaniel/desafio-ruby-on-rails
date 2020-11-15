# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_14_224101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "balance", precision: 9, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.integer "code", null: false
    t.string "description", null: false
    t.string "way", null: false
    t.string "signal_char", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_transaction_types_on_code", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "transaction_type_id", null: false
    t.bigint "company_id", null: false
    t.datetime "occurrence_at", null: false
    t.decimal "amount", precision: 9, scale: 2, default: "0.0"
    t.string "document", null: false
    t.string "card_number", null: false
    t.string "owner_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_transactions_on_company_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
  end

  add_foreign_key "transactions", "companies"
  add_foreign_key "transactions", "transaction_types"
end
