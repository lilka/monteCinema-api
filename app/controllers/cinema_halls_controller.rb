# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  def index
    render json: CinemaHalls::Representers::Multiple.new.call
  end

  def show
    cinema_hall = CinemaHalls::UseCases::Show.new(id: params[:id]).call
    render json: CinemaHalls::Representers::Single.new(cinema_hall)
  end

  def create
    cinema_hall = CinemaHalls::UseCases::Create.new(params: cinema_hall_params).call 
    byebug
    render json: CinemaHalls::Representers::Single.new(cinema_hall).call, status: :created
    rescue  ActiveRecord::RecordInvalid => e
     render status: :bad_request, json: { errors: [e] }
    
  end

  def update
    updated_cinema_hall = CinemaHalls::UseCases::Update.new(params: cinema_hall_params, id: params[:id]).call
    if updated_cinema_hall.errors.any?
      render json: updated_cinema_hall.errors, status: :unprocessable_entity
    else
      render json: CinemaHalls::Representers::Single.new(updated_cinema_hall).call, status: :created
    end
  end

  # DELETE /cinema_halls/1
  def destroy
    cinema_hall = CinemaHall.find(params[:id])
    cinema_hall.destroy
  end

  private

  def cinema_hall_params
    params.permit(:number_of_seats, :name)
  end
end
