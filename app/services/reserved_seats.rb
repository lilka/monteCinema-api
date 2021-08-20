# frozen_string_literal: true

class ReservedSeats < ApplicationController
  def initialize(screening_id)
    @screening_id = screening_id
  end

  def call
    reserved_seats(@screening_id)
  end

  private

  def reserved_seats(screening_id)
    Seat.where(screening_id: screening_id).joins(:reservations_seats).ids
  end
end
