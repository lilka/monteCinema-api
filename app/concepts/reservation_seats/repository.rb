# frozen_string_literal: true

module ReservationSeats
  class Repository
    attr_reader :adapter

    def initialize(adapter: ReservationsSeats)
      @adapter = adapter
    end

    def reserved_seats(screening_id)
      adapter.select(:seat_id).joins(:seat).where('seats.screening_id = ?', screening_id).pluck(:seat_id)
    end

    def create(seat_id, reservation_id)
      adapter.create(seat_id: seat_id, reservation_id: reservation_id)
    end

    def delete_by(reservation_id)
      adapter.where(reservation_id: reservation_id).delete_all
    end
  end
end
