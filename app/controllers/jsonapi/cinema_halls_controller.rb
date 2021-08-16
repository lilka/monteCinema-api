# frozen_string_literal: true

module Jsonapi
  class CinemaHallsController < ApplicationController
    include JSONAPI::Fetching
    include JSONAPI::Filtering

    before_action :set_cinema_halls, only: %i[show update]
    # GET /jsonapi/cinema_halls
    def index
      allowed = %i[name number_of_seats]

      jsonapi_filter(CinemaHall.all, allowed) do |filtered|
        render jsonapi: filtered.result
      end
    end

    # GET /jsonapi/cinema_halls/1
    def show
      render jsonapi: @cinema_hall
    end

    # POST /jsonapi/cinema_halls
    def create
      @cinema_hall = CinemaHall.new(cinema_hall_params)

      if @cinema_hall.save
        render jsonapi: @cinema_hall, status: :created, location: @cinema_hall
      else
        render jsonapi: @cinema_hall.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /jsonapi/cinema_halls/1
    def update
      if @cinema_hall.update
        render jsonapi: @cinema_hall
      else
        render jsonapi: @cinema_hall.errors, status: :unprocessable_entity
      end
    end

    # DELETE /jsonapi/cinema_halls/1
    def destroy
      cinema_hall = CinemaHall.find(params[:id])
      cinema_hall.destroy
    end

    private

    def set_cinema_halls
      @cinema_hall = cinema_hall_hash(CinemaHall.find(params[:id]))
    end

    def cinema_hall_params
      params.permit(:number_of_seats, :name)
    end

    def cinema_hall_hash(cinema_hall)
      {
        id: cinema_hall.id,
        name: cinema_hall.name,
        number_of_seats: cinema_hall.number_of_seats
      }
    end
  end
end
