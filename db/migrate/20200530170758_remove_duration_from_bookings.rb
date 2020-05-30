class RemoveDurationFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :duration
  end
end
