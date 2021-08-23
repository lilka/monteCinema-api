# frozen_string_literal: true

class Seat < ApplicationRecord
  has_many :seats, :through => :reservations_seats
end
