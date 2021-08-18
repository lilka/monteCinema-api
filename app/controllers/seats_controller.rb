# frozen_string_literal: true

class SeatsController < ApplicationController
  before_action :set_seats, only: %i[show destroy]
  # GET /seats
  def index
    seats = Seat.all

    render json: seats
  end

  # GET /seats/1
  def show
    render json: @seat
  end

  # DELETE /seats/1
  def destroy
    seat = Seat.find(params[:id])
    seat.destroy
    return head :no_content
  end

  private

  def set_seats
    @seat = Seat.find(params[:id])
  end
end
