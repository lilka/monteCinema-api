# frozen_string_literal: true

class AssignSeats
  def initialize(reservation_id, seat_ids, screening_id)
    @reservation_id = reservation_id
    @seat_ids = seat_ids
    @screening_id = screening_id
  end

  def call
    raise 'Error: seat not avaliable' if are_seats_free == true

    @seat_ids.each do |seat_id|
      ReservationsSeats.create(seat_id: seat_id, reservation_id: @reservation_id)
    end
  end

  def are_seats_free
    seats = ReservedSeats.new(@screening_id).call
    (seats & @seat_ids).any?
  end
end
