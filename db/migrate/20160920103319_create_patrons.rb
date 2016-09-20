class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
