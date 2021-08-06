# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  def index
    cinema_halls = CinemaHall.all
    cinema_halls = CinemaHall.where('name like ?', "%#{params[:name]}%") if params[:name]

    render json: cinema_halls
  end

  def show
    cinema_halls = CinemaHall.find(params[:id])
    render json: cinema_halls
  end
end
