class ChangeStatusToRenewStatus < ActiveRecord::Migration
  def change
    rename_column :churches, :status, :renew_status
  end
end
