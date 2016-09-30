class AddDiocesanFundedStaffToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :diocesan_funded_staff, :integer
  end
end
