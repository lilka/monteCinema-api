# frozen_string_literal: true

class IsEnoughSeats
  def initialize(seats_to_reserve, screening_id, repository: ReservationSeats::Repository.new)
    @seats_to_reserve = seats_to_reserve
    @screening_id = screening_id
    @repository = repository
  end

  def call
    (Seat.all.count - repository.reserved_seats(screening_id).count - seats_to_reserve).positive?
  end

  private

  attr_reader :seats_to_reserve, :repository, :screening_id
end
