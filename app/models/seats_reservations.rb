# frozen_string_literal: true

class SeatsReservations < ApplicationRecord
  belongs_to :seat
  belongs_to :reservation
end
