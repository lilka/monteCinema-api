module Movies
  class Model < ApplicationRecord
    self.table_name = :movies
    has_many :screenings, dependent: :destroy
    validates :duration, numericality: { greater_than: 1 }
  end
end
