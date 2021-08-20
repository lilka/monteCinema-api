# frozen_string_literal: true

class AssignSeats
  def initialize(reservation_id, seat_ids, screening_id)
    @reservation = Reservation.find(reservation_id)
    @seat_ids = seat_ids
    @screening_id = screening_id
  end

  def call
    if are_seats_free == false
      @seat_ids.each do |seat_id|
        seat = Seat.find(seat_id)
        @reservation.seats.push(seat)
      end
    else
      raise 'Error: seat not avaliable'
    end
  end

  def are_seats_free
    seats = ReservedSeats.new(@screening_id).call
    (seats & @seat_ids).any?
  end
end
