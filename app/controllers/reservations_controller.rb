# frozen_string_literal: true

class ReservationsController < ApplicationController
  def index
    render json: Reservations::Representers::Multiple.new.call
  end

  def show
    reservations = Reservations::UseCases::Show.new(id: params[:id]).call
    render json: Reservations::Representers::Single.new(reservations).call
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  def create
    reservation = Reservations::UseCases::Create.new(params: reservation_params).call
    render json: Reservations::Representers::Single.new(reservation).call
  rescue Reservations::UseCases::Create::SeatsNotValidError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  private

  def reservation_params
    params.permit(:user_id, :screening_id, seat_ids: [])
  end
end
