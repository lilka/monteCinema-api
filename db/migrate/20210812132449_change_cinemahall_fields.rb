class ChangeCinemahallFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :cinema_halls :row_number 
    remove_column :cinema_halls :seats_in_row
    add_column :cinema_halls :number_of_seats 
  end
end
