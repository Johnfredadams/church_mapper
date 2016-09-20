class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :encrypted_address
      t.string :encrypted_postcode
      t.string :encrypted_landline

      t.timestamps null: false
    end
  end
end
