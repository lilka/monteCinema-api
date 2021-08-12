# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    movies = Movie.all
    movies = movies.where('title like ?', "%#{params[:title]}%") if params[:title]

    render json: movies
  end

  def show
    movies = Movie.find(params[:id])

    render json: movies
  end
end
