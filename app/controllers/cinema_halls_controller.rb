# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :set_cinema_halls, only: %i[show update destroy]
  # GET /cinema_halls
  def index
    @cinema_halls = CinemaHall.all
    @cinema_halls = CinemaHall.where('name like ?', "%#{params[:name]}%") if params[:name]

    render json: @cinema_halls
  end

  # GET /cinema_halls/1
  def show
    render json: @cinema_hall
  end

  # POST /cinema_halls
  def create
    @cinema_hall = CinemaHall.new(cinema_hall_params)

    if @cinema_hall.save
      render json: @cinema_hall, status: :created, location: @cinema_hall
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cinema_halls/1
  def update
    if @cinema_hall.update(cinema_hall_params)
      render json: @cinema_hall
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cinema_halls/1
  def destroy
    @cinema_hall.destroy
  end

  private

  def set_cinema_halls
    @cinema_hall = CinemaHall.find(params[:id])
  end

  def cinema_hall_params
    params.required(:cinema_hall).permit(:number_of_seats, :name)
  end
end
