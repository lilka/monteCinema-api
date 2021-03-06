# frozen_string_literal: true

class CinemaHall < ApplicationRecord
  has_many :seats
  has_many :screenings
  validates :name, presence: true, allow_blank: false
  validates :number_of_seats, presence: true, numericality: { greater_than: 0 }
end
