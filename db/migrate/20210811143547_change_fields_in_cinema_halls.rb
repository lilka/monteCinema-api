class ChangeFieldsInCinemaHalls < ActiveRecord::Migration[6.1]
  def change
    remove_column :cinema_halls, :seats_in_row
    remove_column :cinema_halls, :row_number
    add_column :cinema_halls, :number_of_seats, :integer
  end
end
