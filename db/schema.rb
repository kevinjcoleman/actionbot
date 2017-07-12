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

ActiveRecord::Schema.define(version: 20170709225817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country_code"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "bot_events", force: :cascade do |t|
    t.bigint "page_bot_id"
    t.string "name"
    t.text "description"
    t.string "picture_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_bot_id"], name: "index_bot_events_on_page_bot_id"
  end

  create_table "event_rsvps", force: :cascade do |t|
    t.bigint "bot_event_id"
    t.bigint "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bot_event_id"], name: "index_event_rsvps_on_bot_event_id"
    t.index ["sender_id"], name: "index_event_rsvps_on_sender_id"
  end

  create_table "page_bots", force: :cascade do |t|
    t.string "access_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "page_id"
    t.string "picture_url"
    t.index ["user_id"], name: "index_page_bots_on_user_id"
  end

  create_table "referrers", force: :cascade do |t|
    t.bigint "referrer_id"
    t.bigint "referree_id"
    t.string "referrable_type"
    t.bigint "referrable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referrable_type", "referrable_id"], name: "index_referrers_on_referrable_type_and_referrable_id"
    t.index ["referree_id"], name: "index_referrers_on_referree_id"
    t.index ["referrer_id"], name: "index_referrers_on_referrer_id"
  end

  create_table "senders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "profile_pic"
    t.string "gender"
    t.string "facebook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_windows", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "timeable_type"
    t.bigint "timeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["timeable_type", "timeable_id"], name: "index_time_windows_on_timeable_type_and_timeable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_url"
  end

  add_foreign_key "bot_events", "page_bots"
  add_foreign_key "page_bots", "users"
  add_foreign_key "referrers", "senders", column: "referree_id"
  add_foreign_key "referrers", "senders", column: "referrer_id"
end
