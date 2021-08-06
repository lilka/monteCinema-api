# frozen_string_literal: true

class CreateCinemaHalls < ActiveRecord::Migration[6.1]
  def change
    create_table :cinema_halls do |t|
      t.integer :row_number
      t.integer :seats_in_row
      t.string :name

      t.timestamps
    end
  end
end
