class AddAgeGroupsToChurchCounts < ActiveRecord::Migration
  def change
    add_column :church_counts, :age_group, :string
  end
end
