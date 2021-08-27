# frozen_string_literal: true

class ScreeningsController < ApplicationController

  def index
    @screenings = Screening.all.map do |screening|
      screening_hash(screening)
    end
    render json: @screenings
  end

  def show
    screening = Screening.find(params[:id])
    transformed_screening = screening_hash(screening)
    render json: transformed_screening
  end

  def update
    screening = Screening.find(params[:id])
    if screening.update(screening_params)
      render json: screening
    else
      render json: screening.errors, status: :unprocessable_entity
    end
  end

  def create
    Screening.transaction do
      @screening = Screening.create!(screening_params)
      GenerateSeats.new(params[:cinema_hall_id], @screening.id).call
    end
    render json: screening_hash(@screening), status: :created, location: @screening
  rescue StandardError => e
    render status: :bad_request, json: { errors: [e] }
  end

  def find(id)
    Screening.find(id)
  end

  private

  def screening_params
    params.permit(:movie_id, :cinema_hall_id, :start_time)
  end

  def screening_hash(screening)
    {
      id: screening.id,
      movie_title: screening.movie.title,
      cinema_hall: screening.cinema_hall.name,
      start_time: screening.start_time
    }
  end
end
