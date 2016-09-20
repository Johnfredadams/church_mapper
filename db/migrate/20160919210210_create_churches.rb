class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :name
      t.string :parish
      t.string :locality
      t.string :diocese
      t.string :postcode
      t.string :status
      t.text :description
      t.string :vacant
      t.integer :start_month
      t.integer :start_year
      t.string :incumbent_name
      t.integer :incumbent_age
      t.boolean :incumbent_age_approx
      t.integer :incumbent_start_month
      t.integer :incumbent_start_year
      t.integer :average_weekly_attendance
      t.integer :number_of_clergy_employed
      t.integer :number_of_staff
      t.string :funding
      t.string :cofe_status
      t.string :network

      t.timestamps null: false
    end
  end
end
