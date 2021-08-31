# frozen_string_literal: true

module Seats
  module Representers
    class Single
      def initialize(seat)
        @seat = seat
      end

      def call
        {
          id: seat.id,
          row: seat.row,
          number: seat.number
        }
      end

      private

      attr_reader :seat
    end
  end
end
