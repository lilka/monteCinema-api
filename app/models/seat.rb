# frozen_string_literal: true

class Seat < ApplicationRecord
  has_many :reservation, through: :reservations_seats
  belongs_to :screening
end
