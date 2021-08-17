# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservations, only: %i[show]

  def index
    reservations = Reservation.all

    render json: reservations
  end

  def show
    render json: @reservation
  end

  def create
    screening = Screening.find(reservation_params[:screening_id])
    cinema_hall = CinemaHall.find(screening[:cinema_hall_id])
    seats_number_to_reserve = reservation_params[:seats_amount].to_i
    if (avaliable_seats(screening.id).count - seats_number_to_reserve).positive?
      reservation = Reservation.create!({ status: 'pending', paid: false, screening_id: screening.id, user_id: nil })
      seats_number_to_reserve.times do
        seat = avaliable_seats(screening.id).first
        reservation.seats.push(seat)
      end
      render json: reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def set_reservations
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.permit(:status, :paid, :screening_id, :seats_amount)
  end

  def reserved_seats(screening_id)
    Seat.where(screening_id: screening_id).joins(:reservations_seats)
  end

  def avaliable_seats(screening_id)
    Seat.where(screening_id: screening_id) - reserved_seats(screening_id)
  end

  def reservation_hash(reservation)
    
end
