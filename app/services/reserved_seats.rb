# frozen_string_literal: true

class ReservedSeats
  def initialize(screening_id)
    @screening_id = screening_id
  end

  def call
    reserved_seats(@screening_id)
  end

  private

  def reserved_seats(screening_id)
    ReservationsSeats.select(:seat_id).joins(:seat).where('seats.screening_id = ?', screening_id)
  end
end
