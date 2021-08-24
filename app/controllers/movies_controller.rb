# frozen_string_literal: true

class MoviesController < ApplicationController

  def index
    movies = Movies::UseCases::ShowAll.new.call
    render json: Movies::Representers::Multiple.new(movies).call
  end

  def show 
  end

  def create 
    movie = Movies::UseCases::Create.new(params: movie_params).call
    if movie.valid?
      render Movies::Representers::Single.new(movie).call, status: :created
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  def update
    updated_movie = Movies::UseCases::Update.new(params: movie_params, id: params[:id]).call
    if updated_movie.errors.any?
      render updated_movie.errors, status: :unprocessable_entity
    else
      render Movies::Representers::Single.new(updated_movie), status: :created
    end
  end


  private

   def movie_params
    params.permit(:title, :duration, :description)
   end

end
