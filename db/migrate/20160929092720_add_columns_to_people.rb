class AddColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :encrypted_email_iv, :string
    add_column :people, :encrypted_phone_iv, :string
  end
end
