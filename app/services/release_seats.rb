# frozen_string_literal: true

class ReleaseSeats
  def initialize(reservation_id, repository: ReservationSeats::Repository.new)
    @reservation_id = reservation_id
    @repository = repository
  end

  def call
    repository.delete_by(reservation_id: reservation_id)
  end

  private

  attr_reader :repository, :reservation_id
end
