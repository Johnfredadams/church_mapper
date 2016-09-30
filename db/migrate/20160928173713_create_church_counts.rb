class CreateChurchCounts < ActiveRecord::Migration
  def change
    create_table :church_counts do |t|
      t.string :count_type
      t.integer :count_number
      t.integer :count_year
      t.integer :count_month
      t.integer :count_day
      t.boolean :count_approx
      t.integer :church_id

      t.timestamps null: false
    end
  end
end
