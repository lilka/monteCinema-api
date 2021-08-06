# frozen_string_literal: true

class ChangeOptionalityOfAttributes < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:movies, :duration_min, true)
    change_column_null(:movies, :title, true)
    change_column_null(:movies, :description, false)

    change_column_null(:cinema_halls, :name, false)
    change_column_null(:cinema_halls, :row_number, true)
    change_column_null(:cinema_halls, :seats_in_row, true)

    change_column_null(:screenings, :start_time, true)
    change_column_null(:screenings, :date, true)
    change_column_null(:screenings, :movie_id, true)
    change_column_null(:screenings, :cinema_hall_id, true)
  end
end
