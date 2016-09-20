class CreateChurchesPeople < ActiveRecord::Migration
  def change
    create_table :churches_people do |t|
      t.integer :church_id
      t.integer :person_id
      t.integer :start_date_year
      t.integer :start_date_month
      t.integer :start_date_day
      t.integer :end_date_year
      t.integer :end_date_month
      t.integer :end_date_day

      t.timestamps null: false
    end
  end
end
