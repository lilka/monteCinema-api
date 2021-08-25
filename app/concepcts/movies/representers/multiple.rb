# frozen_string_literal: true

module Movies
  module Representers
    class Multiple
      def initialize(movies: Movies::UseCases::ShowAll.new.call)
        @movies = movies
      end

      def call
        @movies.map do |movie|
          Movies::Representers::Single.new(movie).call
        end
      end

      private

      attr_reader :movies
    end
  end
end
