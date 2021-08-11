class ChangeNameInMoviesAndDeleteDateInReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :date
    rename_column :movies, :duration_min, :duration
  end
end
