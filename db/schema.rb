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

ActiveRecord::Schema.define(version: 20150622191645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_codes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "eventbrite_access_code_id"
  end

  add_index "access_codes", ["code"], name: "index_access_codes_on_code", unique: true, using: :btree
  add_index "access_codes", ["eventbrite_access_code_id"], name: "index_access_codes_on_eventbrite_access_code_id", unique: true, using: :btree
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "admin",                  default: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "access_codes", "users"
  add_foreign_key "attendees", "access_codes"
end
