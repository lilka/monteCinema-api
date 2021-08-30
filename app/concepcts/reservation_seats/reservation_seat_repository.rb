# frozen_string_literal: true

module ReservationSeats
  class ReservationSeatRepository
    attr_reader :adapter

    def initialize(adapter: ReservationsSeats)
      @adapter = adapter
    end

    def reserved_seats(screening_id)
      adapter.select(:seat_id).joins(:seat).where('seats.screening_id = ?', screening_id)
    end

    def create(seat_id, reservation_id)
      adapter.create(seat_id: seat_id, reservation_id: reservation_id)
    end
  end
end
