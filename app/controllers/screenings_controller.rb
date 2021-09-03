# frozen_string_literal: true

class ScreeningsController < ApplicationController
  before_action :authenticate_user!, only: [:update, :create]
  def index
    render json: Screenings::Representers::Multiple.new.call
  end

  def show
    screening = Screenings::UseCases::Fetch.new(id: params[:id]).call
    render json: Screenings::Representers::Single.new(screening).call
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  def update
    authorize Screening, :update?
    updated_screening = Screenings::UseCases::Update.new(params: screening_params, id: params[:id]).call
    render json: Screenings::Representers::Single.new(updated_screening).call, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e.message }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  def create
    authorize Screening, :create?
    screening = Screenings::UseCases::Create.new(params: screening_params).call
    render json: Screenings::Representers::Single.new(screening).call, status: :created
  rescue GenerateSeats::InvalidNumberOfSeats => e
    render status: :bad_request, json: { errors: e.message }
  end

  private

  def screening_params
    params.permit(:movie_id, :cinema_hall_id, :start_time)
  end
end
