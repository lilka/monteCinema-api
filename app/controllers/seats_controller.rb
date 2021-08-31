# frozen_string_literal: true

class SeatsController < ApplicationController
  def index
    seats = Seat::UseCases::FetchAll.new.call
    render json: Seats::Representers::Multiple.new(seats).call
  end

  def show
    seat = Seats::UseCases::Show.new(params).call
    render json: Seats::Representers::Single.new(seat).call
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end
end
