class ChangeAssociationBetweenSeats < ActiveRecord::Migration[6.1]
  def change
    remove_reference :seats, :cinema_hall
    add_reference :seats, :screening, null: false, foreign_key: true
  end
end
