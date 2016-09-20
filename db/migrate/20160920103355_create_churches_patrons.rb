class CreateChurchesPatrons < ActiveRecord::Migration
  def change
    create_table :churches_patrons do |t|
      t.integer :church_id
      t.integer :patron_id

      t.timestamps null: false
    end
  end
end
