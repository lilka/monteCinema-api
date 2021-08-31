# frozen_string_literal: true

module Seats
  module Representers
    class Multiple
      def initialize(seats)
        @seats = seats
      end

      def call
        seats.map do |seat|
          Seats::Representers::Single.new(seat).call
        end
      end

      private

      attr_reader :seats
    end
  end
end
