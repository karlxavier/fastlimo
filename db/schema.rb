# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161127111146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.date     "book_date"
    t.string   "book_time"
    t.integer  "car_type_id"
    t.string   "from_name"
    t.float    "from_lat"
    t.float    "from_lng"
    t.string   "to_name"
    t.float    "to_lat"
    t.float    "to_lng"
    t.string   "passenger_name"
    t.string   "telephone_no"
    t.string   "ordered_by"
    t.integer  "payment_type_id"
    t.integer  "corporate_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "booking_status_id"
    t.text     "remarks"
    t.integer  "driver_id"
    t.string   "reference_no"
    t.text     "execute_remarks"
    t.datetime "executed_on"
    t.datetime "finished_on"
    t.integer  "cancel_reason_id"
    t.decimal  "price",             precision: 8, scale: 2
    t.datetime "cancelled_on"
    t.string   "executed_by"
    t.string   "finished_by"
    t.string   "cancelled_by"
  end

  create_table "cancel_reasons", force: :cascade do |t|
    t.string   "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corporate_statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corporates", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "account_no"
    t.integer  "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "corporate_status_id"
  end

  create_table "driver_statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile_no"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "driver_status_id"
    t.text     "remarks"
    t.boolean  "with_vehicle",     default: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_details", force: :cascade do |t|
    t.integer  "rate_master_id"
    t.decimal  "amount",         precision: 8, scale: 2
    t.integer  "pickup"
    t.integer  "dropoff"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "rate_masters", force: :cascade do |t|
    t.string   "tname"
    t.integer  "coporate_id"
    t.integer  "payment_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "corporate_id"
    t.boolean  "super",                  default: false
    t.string   "fullname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "veh_manufacturers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "veh_statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "veh_model"
    t.string   "seat_capacity"
    t.string   "plate_no"
    t.string   "chassis_no"
    t.string   "engine_no"
    t.date     "on_fleet_on"
    t.integer  "veh_manufacturer_id"
    t.integer  "car_type_id"
    t.integer  "veh_status_id"
    t.integer  "driver_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
