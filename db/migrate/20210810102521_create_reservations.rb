# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :screening, null: false, foreign_key: true
      t.datetime :date
      t.boolean :paid
      t.string :status

      t.timestamps
    end
  end
end
