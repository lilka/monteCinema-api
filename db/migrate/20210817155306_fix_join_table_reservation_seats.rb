# frozen_string_literal: true

class FixJoinTableReservationSeats < ActiveRecord::Migration[6.1]
  def change
    drop_table :seats_reservations
    create_join_table :reservations, :seats
  end
end
