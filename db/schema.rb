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

ActiveRecord::Schema.define(version: 20150619190159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_codes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "invitee_name"
    t.string   "invitee_url"
    t.text     "invitee_info"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "eventbrite_access_code_id"
  end

  add_index "access_codes", ["code"], name: "index_access_codes_on_code", unique: true, using: :btree
  add_index "access_codes", ["user_id"], name: "index_access_codes_on_user_id", using: :btree

  create_table "attendees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "access_code_id"
    t.datetime "ordered_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "eventbrite_attendee_id"
  end

  add_index "attendees", ["access_code_id"], name: "index_attendees_on_access_code_id", using: :btree
  add_index "attendees", ["eventbrite_attendee_id"], name: "index_attendees_on_eventbrite_attendee_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.integer  "code_allowance"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "access_codes", "users"
  add_foreign_key "attendees", "access_codes"
end
