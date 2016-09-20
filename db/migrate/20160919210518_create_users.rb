class CreateUsers < ActiveRecord::Migration
  def change
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
end
