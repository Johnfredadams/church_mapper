class AddFieldsToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :house_of_bishops_declaration, :string
    add_column :churches, :house_of_bishops_declaration_other, :text
    add_column :churches, :diocesan_help_for_growth, :boolean
    add_column :churches, :diocesan_help_for_growth_comment, :text
    add_column :churches, :permission_for_mapping, :boolean, default: false
    add_column :churches, :permission_for_sharing, :boolean, default: false
    add_column :churches, :remove_me, :boolean, default: false
  end
end
