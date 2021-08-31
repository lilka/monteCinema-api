# frozen_string_literal: true

module ReservationSeats
  class Validator
    def initialize(seat_ids, screening_id, repository: ReservationSeats::Repository.new, screening_repository: Screenings::Repository.new)
      @seat_ids = seat_ids
      @screening_id = screening_id
      @repository = repository
      @screening_repository = screening_repository
    end

    def valid?
      seats_reserved = repository.reserved_seats(screening_id)
      all_seats = screening_repository.count_number_of_seats(screening_id)
      seats_free(seats_reserved) or enough_seats?(all_seats, seats_reserved)
    end

    private

    attr_reader :repository, :screening_id, :seat_ids, :screening_repository

    def enough_seats?(all_seats, seats_reserved)
      all_seats - seats_reserved.count <= seat_ids.count
    end

    def seats_free(seats_reserved)
      (seats_reserved & seat_ids).any?
    end
  end
end
