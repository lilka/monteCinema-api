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
        assign_seats(seats_number_to_reserve, screening.id)
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

  def reserved_seats(screening_id)
    Seat.where(screening_id: screening_id).joins(:reservations_seats)
  end

  def avaliable_seats(screening_id)
    Seat.where(screening_id: screening_id) - reserved_seats(screening_id)
  end

  def is_enought_seats(screening_id, seats_to_reserve)
    return (avaliable_seats(screening_id).count - seats_to_reserve).positive?
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

  def assign_seats(seats_number_to_reserve, screening_id)
    seats_number_to_reserve.times do
      seat = avaliable_seats(screening_id).first
      @reservation.seats.push(seat)
    end
  end
end
