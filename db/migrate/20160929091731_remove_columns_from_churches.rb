class RemoveColumnsFromChurches < ActiveRecord::Migration
  def change
    remove_column :churches, :incumbent_name
    remove_column :churches, :incumbent_age
    add_column :people, :age, :integer
    add_column :people, :age_approx, :boolean
    
  end
end
