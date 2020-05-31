class Change < ActiveRecord::Migration[6.0]
  def change
    change_column :bookings, :table_no, :integer
  end
end
