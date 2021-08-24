# frozen_string_literal: true

class CinemaHallsController < ApplicationController


  def index
    cinema_halls = CinemaHalls::UseCases::ShowAll.new.call
    render json: CinemaHalls::Representers::Multiple.new(cinema_halls).call
  end

  def show
     cinema_hall = CinemaHalls::UseCases::Show.new(id: params[:id]).call
     render json: CinemaHalls::Representers::Single.new(cinema_hall).call
  end

  def create
    cinema_hall = CinemaHalls::UseCases::Create.new(params: cinema_hall_params).call
    if cinema_hall.valid?
      render CinemaHalls::Representers::Single.new(cinema_hall).call, status: :created
    else
      render json: CinemaHall.errors, status: :unprocessable_entity
    end
  end

  def update
    updated_cinema_hall = CinemaHalls::UseCases::Update.new(params: cinema_hall_params, id: params[:id]).call
    if updated_cinema_hall.errors.any?
      render updated_cinema_hall.errors, status: :unprocessable_entity
    else
      render CinemaHalls::Representers::Single.new(updated_cinema_hall), status: :created
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
