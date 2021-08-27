# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: CinemaHalls::Representers::Multiple.new.call
  end

  def show
    cinema_hall = CinemaHalls::UseCases::Show.new(id: params[:id]).call
    render json: CinemaHalls::Representers::Single.new(cinema_hall)
  end

  def create
    cinema_hall = CinemaHalls::UseCases::Create.new(params: cinema_hall_params).call
    render json: CinemaHalls::Representers::Single.new(cinema_hall).call, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e }
  end

  def update
    updated_cinema_hall = CinemaHalls::UseCases::Update.new(params: cinema_hall_params, id: params[:id]).call
    render json: CinemaHalls::Representers::Single.new(updated_cinema_hall).call, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e }
  end

  private

  def cinema_hall_params
    params.permit(:number_of_seats, :name, :id)
  end
end
