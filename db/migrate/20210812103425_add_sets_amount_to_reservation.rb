# frozen_string_literal: true

class AddSetsAmountToReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :seats_amount, :integer
  end
end
