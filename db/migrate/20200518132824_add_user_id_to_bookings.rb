class AddUserIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :user_id, :int
  end
end
