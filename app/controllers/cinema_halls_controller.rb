# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :authenticate_user!, only: %i[update create]

  def index
    render json: CinemaHalls::Representers::Multiple.new.call
  end

  def show
    cinema_hall = CinemaHalls::UseCases::Fetch.new(id: params[:id]).call
    render json: CinemaHalls::Representers::Single.new(cinema_hall)
  end

  def create
    authorize CinemaHall, :create?
    cinema_hall = CinemaHalls::UseCases::Create.new(params: cinema_hall_params).call
    render json: CinemaHalls::Representers::Single.new(cinema_hall).call, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e }
  end

  def update
    authorize CinemaHall, :update?
    updated_cinema_hall = CinemaHalls::UseCases::Update.new(params: cinema_hall_params, id: params[:id]).call
    render json: CinemaHalls::Representers::Single.new(updated_cinema_hall).call, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  private

  def cinema_hall_params
    params.permit(:number_of_seats, :name, :id)
  end
end
