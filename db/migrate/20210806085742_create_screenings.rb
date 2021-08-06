class CreateScreenings < ActiveRecord::Migration[6.1]
  def change
    create_table :screenings do |t|
      t.references :cinema_hall, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.time :start_time
      t.date :date

      t.timestamps
    end
  end
end
