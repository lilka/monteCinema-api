# frozen_string_literal: true

class MoviesController < ApplicationController

  def index
    movies = Movies::UseCases::ShowAll.new.call
    render json: movies
  end

end
