# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[update create]

  def index
    render json: Movies::Representers::Multiple.new.call
  end

  def show; end

  def create
    authorize Movie, :create?
    movie = Movies::UseCases::Create.new(params: movie_params).call
    render json: Movies::Representers::Single.new(movie).call, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e.message }.to_json
  end

  def update
    authorize Movie, :update?
    updated_movie = Movies::UseCases::Update.new(params: movie_params, id: params[:id]).call
    render json: Movies::Representers::Single.new(updated_movie).call, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: { errors: e.message }.to_json
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  private

  def movie_params
    params.permit(:title, :duration, :description)
  end
end
