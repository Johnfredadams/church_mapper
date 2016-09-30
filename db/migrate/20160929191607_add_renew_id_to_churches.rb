class AddRenewIdToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :renew_database_id, :integer
  end
end
