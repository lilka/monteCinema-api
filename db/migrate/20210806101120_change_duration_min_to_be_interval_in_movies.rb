# frozen_string_literal: true

class ChangeDurationMinToBeIntervalInMovies < ActiveRecord::Migration[6.1]
  def up
    change_column :movies, :duration_min, 'interval USING (duration_min)::interval'
  end

  def down
    change_column :movies, :duration_min, :string
  end
end
