# frozen_string_literal: true

class CreateTableForReservationSeatsRelation < ActiveRecord::Migration[6.1]
  def change
    create_table :seats_reservations, id: false do |t|
      t.belongs_to :seat
      t.belongs_to :reservation
    end
  end
end
