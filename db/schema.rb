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

ActiveRecord::Schema.define(version: 20160920120852) do

  create_table "addresses", force: :cascade do |t|
    t.text     "encrypted_address"
    t.string   "encrypted_postcode"
    t.string   "encrypted_landline"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "churches", force: :cascade do |t|
    t.string   "name"
    t.string   "parish"
    t.string   "locality"
    t.string   "diocese"
    t.string   "postcode"
    t.string   "renew_status"
    t.text     "description"
    t.string   "vacant"
    t.integer  "start_month"
    t.integer  "start_year"
    t.string   "incumbent_name"
    t.integer  "incumbent_age"
    t.boolean  "incumbent_age_approx"
    t.integer  "incumbent_start_month"
    t.integer  "incumbent_start_year"
    t.integer  "average_weekly_attendance"
    t.integer  "number_of_clergy_employed"
    t.integer  "number_of_staff"
    t.string   "funding"
    t.string   "cofe_status"
    t.string   "network"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.float    "lat"
    t.float    "lng"
    t.integer  "renew_region_id"
    t.integer  "diocese_id"
  end

  create_table "churches_patrons", force: :cascade do |t|
    t.integer  "church_id"
    t.integer  "patron_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "churches_people", force: :cascade do |t|
    t.integer  "church_id"
    t.integer  "person_id"
    t.integer  "start_date_year"
    t.integer  "start_date_month"
    t.integer  "start_date_day"
    t.integer  "end_date_year"
    t.integer  "end_date_month"
    t.integer  "end_date_day"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "position"
  end

  create_table "dioceses", force: :cascade do |t|
    t.string   "name"
    t.string   "province"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "encrypted_email"
    t.string   "title"
    t.string   "gender"
    t.string   "encrypted_phone"
    t.date     "renew_member_since"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "renew_regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.text     "oauth_token"
    t.string   "oauth_expires_at",       limit: 255
    t.text     "oauth_refresh_token"
    t.text     "email"
  end

end
