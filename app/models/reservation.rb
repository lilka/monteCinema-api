# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :user, optional: true
  has_many :seats, :through => :reservations_seats
end
