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
    seats_amount = reservation_params[:seats_amount].to_i
    if (cinema_hall[:number_of_seats] - seats_amount).positive?
      reservation = Reservation.create!({ status: 'pending', paid: false, screening_id: 1, user_id: nil, seats_amount: seats_amount})
      cinema_hall.decrement!(:number_of_seats, seats_amount)
      render json: reservation
    else
    
    end
  end

  private
  def set_reservations
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:status, :paid, :screening_id, :seats_amount)
  end
end
