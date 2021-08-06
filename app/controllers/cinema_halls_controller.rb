# frozen_string_literal: true

class CinemaHallsController < ApplicationController
        def index 
            @movies = CinemaHall.all 
            @movies = @movies.where('title like ?', "%#{params[:name]}%") if params[:name]
    
            render json: @movies
        end
    
        def show
            @movies = CinemaHall.find(params[:id])
            render json: @movies
        end 
end
