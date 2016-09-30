class CreateAddressesPeople < ActiveRecord::Migration
  def change
    create_table :addresses_people do |t|
      t.integer :address_id
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
