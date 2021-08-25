# frozen_string_literal: true

module CinemaHalls
  module Representers
    class Multiple
      def initialize(cinema_halls: CinemaHalls::UseCases::ShowAll.new.call)
        @cinema_halls = cinema_halls
      end

      def call
        @cinema_halls.map do |cinema_hall|
          CinemaHalls::Representers::Single.new(cinema_hall).call
        end
      end

      private

      attr_reader :cinema_halls
    end
  end
end
