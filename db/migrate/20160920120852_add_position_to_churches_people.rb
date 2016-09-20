class AddPositionToChurchesPeople < ActiveRecord::Migration
  def change
    add_column :churches_people, :position, :string
  end
end
