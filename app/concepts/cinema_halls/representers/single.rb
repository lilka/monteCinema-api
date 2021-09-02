# frozen_string_literal: true

module CinemaHalls
  module Representers
    class Single
      def initialize(cinema_hall)
        @cinema_hall = cinema_hall
      end

      def call
        {
          id: cinema_hall.id,
          name: cinema_hall.name,
          number_of_seats: cinema_hall.number_of_seats
        }
      end

      private

      attr_reader :cinema_hall
    end
  end
end
