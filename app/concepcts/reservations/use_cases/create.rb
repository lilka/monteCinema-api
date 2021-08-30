# frozen_string_literal: true

module Reservations
  module UseCases
    class Create
      NotEnoughSeatsError = Class.new(StandardError)
      def initialize(params:, repository: ReservationRepository.new, screening_repository: Screenings::ScreeningRepository.new)
        @repository = repository
        @screening_repository = screening_repository
        @params = params
        @screening = screening_repository.find(params[:screening_id])
        @seat_ids = seats_to_array(params[:seat_ids])
      end

      def call
        if IsEnoughSeats.new(seat_ids.count, screening.id).call == false
          raise NotEnoughSeatsError,
                'Not enough seats for this screening'
        end

        Reservation.transaction do
          @reservation = repository.create!({ status: 'pending', paid: false, screening_id: screening.id,
                                              user_id: params[:user_id] })
          AssignSeats.new(@reservation.id, seat_ids, screening.id).call
        end
        @reservation
      end

      private

      attr_reader :params, :repository, :screening_repository, :screening, :seat_ids

      def seats_to_array(seat_ids)
        seat_ids.map(&:to_i)
      end
    end
  end
end
