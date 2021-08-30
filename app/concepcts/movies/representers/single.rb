# frozen_string_literal: true

module Movies
  module Representers
    class Single
      def initialize(movie)
        @movie = movie
      end

      def call
        {
          id: movie.id,
          title: movie.title,
          description: movie.description,
          duration: movie.duration
        }
      end

      private

      attr_reader :movie
    end
  end
end
