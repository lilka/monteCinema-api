# frozen_string_literal: true

class SeatsController < ApplicationController
  before_action :get_screening
  before_action :set_seat, only: %i[show destroy]

  def index
    seats = @screening.seats.all
    render json: seats.order("row, number")
  end

  def show
    render json: @seat
  end

  def destroy
    @seat.destroy
    return head :no_content
  end

  private
  def set_seat
    @seat = @screening.seats.find(params[:id])
  end

  def get_screening
   @screening = Screening.find(params[:screening_id])
  end
end
