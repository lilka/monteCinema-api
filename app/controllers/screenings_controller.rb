# frozen_string_literal: true

class ScreeningsController < ApplicationController
  before_action :set_screening, only:%i[show, update]


  def index
    @screenings = Screening.all

    render json: @screenings
  end
  
  def show
    render json: @screening
  end

  def update 
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
  def set_screening
    @screening = Screening.find(params[:id])
  end

  def screening_params
    params.required(:screening).permit(:movie_id, :cinema_hall_id, :start_time, :date)
  end
end

