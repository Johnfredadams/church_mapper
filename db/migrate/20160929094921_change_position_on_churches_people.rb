class ChangePositionOnChurchesPeople < ActiveRecord::Migration
  def change
    rename_column :churches_people, :position, :church_position
  end
end
