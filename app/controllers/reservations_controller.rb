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
    seats_number_to_reserve = reservation_params[:seats_amount].to_i
    if(is_enought_seats(screening.id, seats_number_to_reserve))
      Reservation.transaction do 
        @reservation = Reservation.create!({ status: 'pending', paid: false, screening_id: screening.id, user_id: nil })
        AssignSeats.new(@reservation.id, seats_number_to_reserve, screening.id).call
      end
      render json: reservation_hash(@reservation)
    else 
      render json: {message: "No more pleaces for this screening"}
    end
  end

  private
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.permit(:screening_id, :seats_amount)
  end


  def is_enought_seats(screening_id, seats_to_reserve)
    return (AvaliableSeats.new(screening_id).call.count - seats_to_reserve).positive?
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
end
