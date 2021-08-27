class ChangeReservationsAndScreenings < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :seats_amount
    remove_column :screenings, :date
    remove_column :screenings, :start_time
    add_column :screenings, :start_time, :datetime
  end
end
