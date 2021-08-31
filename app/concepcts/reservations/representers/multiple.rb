# frozen_string_literal: true

module Reservations
  module Representers
    class Multiple
      def initialize(reservations: Reservations::UseCases::FetchAll.new.call)
        @reservations = reservations
      end

      def call
        @reservations.map do |reservation|
          Reservations::Representers::Single.new(reservation).call
        end
      end

      private

      attr_reader :reservations
    end
  end
end
