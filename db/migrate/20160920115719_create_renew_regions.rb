class CreateRenewRegions < ActiveRecord::Migration
  def change
    create_table :renew_regions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
