# frozen_string_literal: true

class ReservationController < ApplicationController 
  before_action :set_reservations, only:%i[show]


  def show
    render json: @reservations
  end

  def create 
    @screening = Screening.find(params[:screening_id])
    if @screening.number_of_seats > 0 
      @reservation = @screening.reservations.create({status: "pending" , paid: false})
      @screening.number_of_seats--
    else
      
    end
  private
    def set_reservations
      @reservation = Reservation.find(params[:id])
    end  

    def reservation_params
      params.require(:reservation).permit(:status, :paid)
    end
end 

