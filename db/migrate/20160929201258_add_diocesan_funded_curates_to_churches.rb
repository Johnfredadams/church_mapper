class AddDiocesanFundedCuratesToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :diocesan_funded_curates, :integer
  end
end
