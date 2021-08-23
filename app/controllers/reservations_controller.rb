# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show]

  def index
    reservations = Reservation.all

    render json: reservations
  end

  def show
    render json: @reservation
  end

  def create
    screening = Screening.find(reservation_params[:screening_id])
    seat_ids = seats_to_array(reservation_params[:seat_ids])
    if enought_seats?(screening.id, seat_ids.count)
      Reservation.transaction do
        @reservation = Reservation.create!({ status: 'pending', paid: false, screening_id: screening.id, user_id: nil })
        AssignSeats.new(@reservation.id, seat_ids, screening.id).call
      end
      render json: reservation_hash(@reservation)
    else
      render json: { message: 'No more pleaces for this screening' }
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.permit(:screening_id, seat_ids: [])
  end

  def enought_seats?(screening_id, seats_to_reserve)
    (Seat.all.count - ReservedSeats.new(screening_id).call.count - seats_to_reserve).positive?
  end

  def reservation_hash(reservation)
    {
      status: reservation.status,
      paid: reservation.paid,
      screening: reservation.screening.movie.title,
      start_time: reservation.screening.start_time,
      cinema_hall: reservation.screening.cinema_hall.name,
      seats: reservation.seats
    }
  end

  def seats_to_array(seat_ids)
    seat_ids.map(&:to_i)
  end
end
