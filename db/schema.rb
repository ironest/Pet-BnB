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

ActiveRecord::Schema.define(version: 2019_10_26_132747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "petsitter_id"
    t.bigint "pet_id"
    t.date "from_date"
    t.date "to_date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_bookings_on_pet_id"
    t.index ["petsitter_id"], name: "index_bookings_on_petsitter_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "pet_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "petsitters", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "price_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_petsitters_on_user_id"
  end

  create_table "petsitters_services", force: :cascade do |t|
    t.bigint "petsitter_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["petsitter_id"], name: "index_petsitters_services_on_petsitter_id"
    t.index ["service_id"], name: "index_petsitters_services_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "booking_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_transactions_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "pets"
  add_foreign_key "bookings", "petsitters"
  add_foreign_key "bookings", "users"
  add_foreign_key "pets", "users"
  add_foreign_key "petsitters", "users"
  add_foreign_key "petsitters_services", "petsitters"
  add_foreign_key "petsitters_services", "services"
  add_foreign_key "transactions", "bookings"
end
