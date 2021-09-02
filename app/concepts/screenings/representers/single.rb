# frozen_string_literal: true

module Screenings
  module Representers
    class Single
      def initialize(screening)
        @screening = screening
      end

      def call
        {
          id: screening.id,
          movie_title: screening.movie.title,
          cinema_hall: screening.cinema_hall.name,
          start_time: screening.start_time
        }
      end

      private

      attr_reader :screening
    end
  end
end
