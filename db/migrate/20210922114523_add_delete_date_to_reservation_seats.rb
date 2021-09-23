class AddDeleteDateToReservationSeats < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations_seats, :reserved_at, :datetime
  end
end
