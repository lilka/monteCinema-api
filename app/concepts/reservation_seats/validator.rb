# frozen_string_literal: true

module ReservationSeats
  class Validator
    def initialize(params, repository: ReservationSeats::Repository.new, screening_repository: Screenings::Repository.new)
      @seat_ids = seats_to_i(params[:seat_ids])
      @screening_id = params[:screening_id]
      @repository = repository
      @screening_repository = screening_repository
    end

    def valid?
      seats_reserved = repository.reserved_seats(screening_id)
      all_seats = screening_repository.count_number_of_seats(screening_id)
      seats_free(seats_reserved) && enough_seats?(all_seats, seats_reserved)
    end

    private

    attr_reader :repository, :screening_id, :seat_ids, :screening_repository

    def enough_seats?(all_seats, seats_reserved)
      all_seats - seats_reserved.count >= seat_ids.count
    end

    def seats_free(seats_reserved)
      seat_ids.none? { |id| seats_reserved.include?(id) }
    end

    def seats_to_i(seat_ids)
      seat_ids.map(&:to_i)
    end
  end
end
