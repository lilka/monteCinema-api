# frozen_string_literal: true

class AssignSeats
  SeatsNotAvaliableError = Class.new(StandardError)
  def initialize(reservation_id, seat_ids, screening_id, repository: ReservationSeats::ReservationSeatRepository.new)
    @reservation_id = reservation_id
    @seat_ids = seat_ids
    @screening_id = screening_id
    @repository = repository
  end

  def call
    raise SeatsNotAvaliableError, 'Error: seat not avaliable' if CheckSeatsAvailability.new(seat_ids,
                                                                                            screening_id).call == true

    seat_ids.each do |seat_id|
      repository.create(seat_id, reservation_id)
    end
  end

  private

  attr_reader :repository, :screening_id, :reservation_id, :seat_ids
end
