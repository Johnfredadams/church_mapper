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

ActiveRecord::Schema.define(version: 20160930111704) do

  create_table "addresses", force: :cascade do |t|
    t.text     "encrypted_address"
    t.string   "encrypted_postcode"
    t.string   "encrypted_landline"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "encrypted_landline_iv"
    t.string   "encrypted_postcode_iv"
    t.string   "encrypted_addresss_iv"
  end

  create_table "addresses_people", force: :cascade do |t|
    t.integer  "address_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "church_counts", force: :cascade do |t|
    t.string   "count_type"
    t.integer  "count_number"
    t.integer  "count_year"
    t.integer  "count_month"
    t.integer  "count_day"
    t.boolean  "count_approx"
    t.integer  "church_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "age_group"
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
    t.boolean  "incumbent_age_approx"
    t.integer  "incumbent_start_month"
    t.integer  "incumbent_start_year"
    t.integer  "average_weekly_attendance"
    t.integer  "number_of_male_clergy_employed"
    t.integer  "number_of_male_laity_employed"
    t.string   "funding"
    t.string   "cofe_status"
    t.string   "network"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.float    "lat"
    t.float    "lng"
    t.integer  "renew_region_id"
    t.integer  "diocese_id"
    t.string   "house_of_bishops_declaration"
    t.text     "house_of_bishops_declaration_other"
    t.boolean  "diocesan_help_for_growth"
    t.text     "diocesan_help_for_growth_comment"
    t.boolean  "permission_for_mapping",             default: false
    t.boolean  "permission_for_sharing",             default: false
    t.boolean  "remove_me",                          default: false
    t.integer  "renew_database_id"
    t.integer  "number_of_female_clergy_employed"
    t.integer  "number_of_female_laity_employed"
    t.integer  "diocesan_funded_staff"
    t.integer  "diocesan_funded_curates"
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
    t.string   "church_position"
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
    t.integer  "age"
    t.boolean  "age_approx"
    t.string   "encrypted_email_iv"
    t.string   "encrypted_phone_iv"
  end

  create_table "renew_regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context"
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type"
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

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
