# frozen_string_literal: true

class ReservationsSeats< ApplicationRecord
  belongs_to :seat
  belongs_to :reservation
end
