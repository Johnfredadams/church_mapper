class AddFieldsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :encrypted_landline_iv, :string
    add_column :addresses, :encrypted_postcode_iv, :string
    add_column :addresses, :encrypted_addresss_iv, :string
  end
end
