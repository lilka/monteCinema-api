# frozen_string_literal: true

class CinemaHall < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :screenings, dependent: :destroy
end
