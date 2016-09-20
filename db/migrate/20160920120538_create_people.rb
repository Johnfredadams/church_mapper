class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :encrypted_email
      t.string :title
      t.string :gender
      t.string :encrypted_phone
      t.date :renew_member_since

      t.timestamps null: false
    end
  end
end
