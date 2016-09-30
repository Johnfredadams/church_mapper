class ChangeNumberOfStaffOnChurches < ActiveRecord::Migration
  def change
    rename_column :churches, :number_of_staff, :number_of_laity_employed
  end
end
