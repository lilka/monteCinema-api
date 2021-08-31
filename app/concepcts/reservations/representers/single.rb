# frozen_string_literal: true

module Reservations
  module Representers
    class Single
      def initialize(reservation)
        @reservation = reservation
      end

      def call
        {
          status: reservation.status,
          paid: reservation.paid,
          screening: reservation.screening.movie.title,
          start_time: reservation.screening.start_time,
          cinema_hall: reservation.screening.cinema_hall.name
        }
      end

      private

      attr_reader :reservation
    end
  end
end
