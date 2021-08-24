  class Movie < ApplicationRecord
    has_many :screenings, dependent: :destroy
    validates :duration, numericality: { greater_than: 1 }
  end

