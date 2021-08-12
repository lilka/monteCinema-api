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
      render json: @screening
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  def create
    @screening = Screening.new(screening_params)

    if @screening.save
      render json: @screening, status: :created, location: @screening
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  private

  def screening_params
    params.required(:screening).permit(:movie_id, :cinema_hall_id, :start_time, :date)
  end

  def screening_hash(screening)
    {
      movie_title: screening.movie.title,
      cinema_hall: screening.cinema_hall.name,
      start_time: screening.start_time,
      date: screening.date
    }
  end
end
