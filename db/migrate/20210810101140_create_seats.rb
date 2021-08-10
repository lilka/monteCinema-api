# frozen_string_literal: true

class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.references :cinema_hall, null: false, foreign_key: true
      t.integer :row
      t.integer :number

      t.timestamps
    end
  end
end
