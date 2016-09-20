class AddLatAndLangToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :lat, :float
    add_column :churches, :lng, :float
  end
end
