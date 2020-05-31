class ChangeTableNoToTableIdBookings < ActiveRecord::Migration[6.0]
  def change
    rename_column :bookings, :table_no, :table_id
  end
end
