class AddRenewGroupAndDioceseToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :renew_region_id, :integer
    add_column :churches, :diocese_id, :integer
  end
end
