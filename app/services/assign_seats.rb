# frozen_string_literal: true

class AssignSeats
  def initialize(reservation_id, params, repository: ReservationSeats::Repository.new)
    @reservation_id = reservation_id
    @seat_ids = params[:seat_ids]
    @screening_id = params[:screening_id]
    @repository = repository
  end

  def call
    seat_ids.each do |seat_id|
      repository.create(seat_id.to_i, reservation_id)
    end
  end

  private

  attr_reader :repository, :screening_id, :reservation_id, :seat_ids
end
