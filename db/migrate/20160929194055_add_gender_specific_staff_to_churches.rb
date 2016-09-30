class AddGenderSpecificStaffToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :number_of_female_clergy_employed, :integer
    add_column :churches, :number_of_female_laity_employed, :integer
    rename_column :churches, :number_of_clergy_employed, :number_of_male_clergy_employed
    rename_column :churches, :number_of_laity_employed, :number_of_male_laity_employed
  end
end
