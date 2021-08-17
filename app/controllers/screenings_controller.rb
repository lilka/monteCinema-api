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
      generate_seat(@screening)
      render json: @screening, status: :created, location: @screening
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  private

  def screening_params
    params.permit(:movie_id, :cinema_hall_id, :start_time, :date)
  end

  def screening_hash(screening)
    {
      movie_title: screening.movie.title,
      cinema_hall: screening.cinema_hall.name,
      start_time: screening.start_time,
      date: screening.date
    }
  end

  def generate_seat(screening)
    cinema_hall = CinemaHall.find(screening[:cinema_hall_id])
    case cinema_hall[:number_of_seats]
    when 200
      fill_seats(20, 10, screening.id)
    when 100
      fill_seats(10, 10, screening.id)
    when 50
      fill_seats(5, 10, screening.id)
    when 20
      fill_seats(5, 4, screening.id)
    else
      'Error: invalid number of seats'
    end
  end

  def fill_seats(rows, seats_in_row, screening_id)
    (1...rows + 1).each do |i|
      (1...seats_in_row + 1).each do |j|
        Seat.create(row: j, number: i, screening_id: screening_id)
      end
    end
  end
end
