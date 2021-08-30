# frozen_string_literal: true

class CheckSeatsAvailability
  def initialize(seat_ids, screening_id, repository: ReservationSeats::ReservationSeatRepository.new)
    @seat_ids = seat_ids
    @screening_id = screening_id
    @repository = repository
  end

  def call
    seats = repository.reserved_seats(screening_id)
    (seats & seat_ids).any?
  end

  private

  attr_reader :repository, :screening_id, :seat_ids
end
